import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/core/app_consts.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/category_selection/category_selection_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/filter_cubit.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/white_glove/presentation/widgets/white_glove_delivery_widget.dart';

class SelectProductCategoryPage extends StatefulWidget {
  const SelectProductCategoryPage({
    required this.appNavigator,
    required this.isFiltering,
    super.key,
  });

  final AppNavigator appNavigator;
  final bool isFiltering;

  @override
  State<SelectProductCategoryPage> createState() => _SelectProductCategoryPageState();
}

class _SelectProductCategoryPageState extends State<SelectProductCategoryPage> {
  late PageController _pageController;
  bool isMasterAccount = false;

  @override
  void initState() {
    _pageController = PageController();
    _getIsMasterUser();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _getIsMasterUser() async {
    final authService = GetIt.I.get<AuthService>();
    isMasterAccount = await authService.getUserIsMaster() ?? false;
    setState(() {});
  }

  void _sendFilter(String categoryId) {
    context.read<FilterCubit>().selectFilters(
          category: categoryId,
        );

    context.read<FilterCubit>().applyFilters();

    GetIt.I.get<AppNavigator>().popUntilRoute(Routes.main);
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    final borderColor = theme.colors.neutral.light.one;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (_pageController.page == 0) {
            widget.appNavigator.pop(context);
          } else {
            context.read<CategorySelectionCubit>().goBack();
          }
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + theme.spacing.inline.xxs,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: theme.spacing.inline.xs,
                  horizontal: theme.spacing.inline.sm,
                ),
                child: Row(
                  children: [
                    ClickableWidget(
                      onTap: () {
                        if (_pageController.page == 0) {
                          widget.appNavigator.pop(context);
                        } else {
                          context.read<CategorySelectionCubit>().goBack();
                        }
                      },
                      borderRadius: BorderRadius.circular(theme.borders.radius.small),
                      child: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: theme.colors.neutral.dark.two,
                      ),
                    ),
                    SizedBox(width: theme.spacing.inline.xs),
                    DSText(
                      widget.isFiltering ? 'Categories' : 'List an item',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                        fontWeight: theme.font.weight.semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              ThemeDividerWidget(color: borderColor),
              BlocListener<CategorySelectionCubit, CategorySelectionState>(
                listener: (context, state) {
                  if (state is CategorySelectionError) {
                    ScaffoldMessenger.of(context).showErrorSnackBar(
                      context,
                      content: state.message,
                    );
                  } else if (state is CategorySelectionLoaded) {
                    // Navega para a página que corresponde ao nível atual do caminho
                    _pageController.animateToPage(
                      state.navigationPath.length,
                      duration: const Duration(milliseconds: AppConsts.kDefaultAnimationInMS),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: BlocBuilder<CategorySelectionCubit, CategorySelectionState>(
                  builder: (context, state) {
                    if (state is CategorySelectionLoading) {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: List.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.only(bottom: theme.spacing.inline.xs),
                                child: const ShimmerComponent(
                                  height: 55,
                                  width: double.infinity,
                                  hasBorderRadius: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is CategorySelectionError) {
                      return Expanded(
                        child: MainPageErrorWidget(
                          onRetry: () {
                            context.read<CategorySelectionCubit>().loadCategories();
                          },
                        ),
                      );
                    }

                    if (state is CategorySelectionLoaded) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!widget.isFiltering) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: theme.spacing.inline.xs,
                                  horizontal: theme.spacing.inline.sm,
                                ),
                                child: DSText(
                                  state.navigationPath.isEmpty ? 'What are you selling?' : state.navigationPath.last.name,
                                  customStyle: TextStyle(
                                    fontSize: theme.font.size.xs,
                                    fontWeight: theme.font.weight.semiBold,
                                  ),
                                ),
                              ),
                              ThemeDividerWidget(
                                color: borderColor,
                              ),
                            ] else if (state.navigationPath.isNotEmpty) ...[
                              CategoryItemWidget(
                                category: state.navigationPath.last.copyWith(
                                  name: 'All Category',
                                ),
                                onCategorySelected: (category) {
                                  _sendFilter(category.id);
                                },
                              ),
                            ],
                            Expanded(
                              child: PageView.builder(
                                controller: _pageController,

                                physics: const NeverScrollableScrollPhysics(), // Navegação controlada pelo Cubit
                                itemCount: state.navigationPath.length + 1,
                                itemBuilder: (context, index) {
                                  // Se for a primeira página, exibe as categorias de nível superior
                                  List<CategoryEntity> categories;
                                  if (index == 0) {
                                    categories = state.categories;
                                  } else {
                                    final selected = state.navigationPath[index - 1];
                                    categories = selected.subcategories ?? [];
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      return CategoryItemWidget(
                                        category: category,
                                        onCategorySelected: (category) {
                                          if (category.subcategories?.isEmpty == true) {
                                            if (widget.isFiltering) {
                                              _sendFilter(category.id);
                                              return;
                                            }

                                            final type = state.navigationPath.last.type;
                                            widget.appNavigator.pushRoute(
                                              Routes.createProduct,
                                              queryParameters: {
                                                'categoryId': category.id,
                                                'categoryName': category.name,
                                                'categoryType': type?.name ?? '',
                                              },
                                            );
                                            return;
                                          }

                                          context.read<CategorySelectionCubit>().selectCategory(category);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            if (!widget.isFiltering && !isMasterAccount) ...[
                              ThemeDividerWidget(
                                color: borderColor,
                              ),
                              FadeSwitcher(
                                child: () {
                                  if (state.navigationPath.isEmpty) {
                                    return const WhiteGloveDeliveryWidget();
                                  } else {
                                    return const SizedBox();
                                  }
                                }(),
                              ),
                              SizedBox(height: theme.spacing.inline.sm),
                            ],
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    required this.category,
    required this.onCategorySelected,
    super.key,
  });

  final CategoryEntity category;
  final Function(CategoryEntity) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    final borderColor = theme.colors.neutral.light.one;
    return ClickableWidget(
      onTap: () {
        onCategorySelected.call(category);
      },
      borderRadius: BorderRadius.circular(theme.borders.radius.small),
      child: Ink(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: theme.borderWidth.thin,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.inline.xs,
          horizontal: theme.spacing.inline.sm,
        ),
        child: Row(
          children: [
            DSText(
              category.name,
              customStyle: TextStyle(
                fontSize: theme.font.size.xs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_outlined,
              color: theme.colors.neutral.dark.two,
            ),
          ],
        ),
      ),
    );
  }
}
