import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/auth/auth_service.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/divider/divider_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/commission_extension.dart';
import 'package:neighborhood_market/app/common/extensions/price_extension.dart';
import 'package:neighborhood_market/app/common/formatter/price_formatter.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/builder_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/create_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/checkbox_label/checkbox_label_widget.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/condiction_choice/choice_selector_widget.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/confirm_clear_item_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/product_images/product_images_widget.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/seller_user_selection/seller_user_selection_widget.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/terms_agreement/terms_agreement_widget.dart';
import 'package:neighborhood_market/app/features/create_product/utils/create_product_strings.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({
    required this.appNavigator,
    required this.createCubit,
    required this.builderCubit,
    this.category,
    this.id,
    super.key,
  });

  final String? id;
  final CategoryEntity? category;
  final AppNavigator appNavigator;
  final CreateProductCubit createCubit;
  final BuilderProductCubit builderCubit;

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController flawsDetailsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isUserMaster = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    detailsController.dispose();
    priceController.dispose();
    brandController.dispose();
    super.dispose();
  }

  void _clearState() {
    titleController.text = '';
    descriptionController.text = '';
    detailsController.text = '';
    flawsDetailsController.text = '';
    priceController.text = '';
    brandController.text = '';
  }

  @override
  void initState() {
    _getIsMasterUser();
    super.initState();
  }

  Future<void> _getIsMasterUser() async {
    final authService = GetIt.I.get<AuthService>();
    isUserMaster = await authService.getUserIsMaster() ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    final borderColor = theme.colors.neutral.light.one;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => widget.createCubit,
        ),
        BlocProvider(
          create: (context) => widget.builderCubit
            ..updateState(category: widget.category)
            ..getProduct(widget.id),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + theme.spacing.inline.xxs,
          ),
          child: BlocConsumer<BuilderProductCubit, BuilderProductState>(
            listener: (context, state) {
              if (state is BuilderProductInfos && state.isEditing && state.isInitialLoad) {
                titleController.text = state.product.title;
                descriptionController.text = state.product.description ?? '';
                detailsController.text = state.product.details ?? '';
                priceController.text = (state.product.price ?? 0.0).toCurrency();
                brandController.text = state.product.brand ?? '';
                detailsController.text = state.product.details ?? '';
                flawsDetailsController.text = state.product.flaws ?? ''; 
              } else if (state is BuilderProductError) {
                showDSBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  child: ErrorBottomSheetWidget(
                    message: 'An error occurred while loading the product. Please try again later.',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is BuilderProductLoading || state is BuilderProductError) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              final product = (state as BuilderProductInfos).product;
              final isEditing = state.isEditing;

              final images = product.images ?? [];
              final bool showAddButton = images.length < 5;

              return Column(
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
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(theme.borders.radius.small),
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: theme.colors.neutral.dark.two,
                          ),
                        ),
                        SizedBox(width: theme.spacing.inline.xs),
                        DSText(
                          product.category?.name ?? '',
                          customStyle: TextStyle(
                            fontSize: theme.font.size.xs,
                            fontWeight: theme.font.weight.semiBold,
                          ),
                        ),
                        const Spacer(),
                        ClickableWidget(
                          borderRadius: BorderRadius.circular(theme.borders.radius.small),
                          onTap: () {
                            showDSBottomSheet(
                              context: context,
                              isScrollControlled: false,
                              child: ConfirmClearItemBottomSheet(
                                onTap: () {
                                  _clearState();
                                  context.read<BuilderProductCubit>().clearState();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.inline.xxs,
                            ),
                            child: const DSText(CreateProductStrings.clearButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ThemeDividerWidget(color: borderColor),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: theme.spacing.inline.xs,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height: theme.spacing.inline.sm),
                              ProductImagesWidget(
                                showAddButton: showAddButton,
                                images: images,
                              ),
                              SizedBox(height: theme.spacing.inline.xxs),
                              DSText(
                                CreateProductStrings.imageInputDescription,
                                customStyle: TextStyle(
                                  color: theme.colors.neutral.dark.two,
                                  fontSize: theme.font.size.xxxs,
                                  fontWeight: theme.font.weight.regular,
                                ),
                              ),
                              SizedBox(height: theme.spacing.inline.sm),
                              TextInputLabelWidget(
                                label: 'Title',
                                hintText: 'Enter product title',
                                tooltip: 'Be specific and descriptive',
                                controller: titleController,
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Title is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: theme.spacing.inline.xs),
                              TextInputLabelWidget(
                                label: 'Description',
                                hintText: 'Enter product description',
                                tooltip: 'Include brand, size, color, and condition',
                                controller: descriptionController,
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Description is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: null,
                                expands: true,
                              ),
                              SizedBox(height: theme.spacing.inline.xs),
                              TextInputLabelWidget(
                                label: 'Brand',
                                hintText: 'Enter product brand',
                                tooltip: 'Enter the brand of the item (optional)',
                                controller: brandController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Brand is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: theme.spacing.inline.xs),
                              ChoiceSelectorWidget(
                                choices: productConditions,
                                label: 'Condition',
                                tooltip: 'Select the condition of the item',
                                selectedId: state.product.tag ?? '',
                                onTap: (tag) {
                                  context.read<BuilderProductCubit>().updateTagList(tag);
                                },
                                errorText: 'Condition is required',
                              ),
                              SizedBox(height: theme.spacing.inline.xs),
                              ChoiceSelectorWidget(
                                choices: ProductGender.values.map((e) => e.label).toList(),
                                label: 'Gender',
                                tooltip: 'Select the gender of the item',
                                selectedId: state.product.gender?.label ?? '',
                                onTap: (gender) {
                                  context.read<BuilderProductCubit>().updateGender(gender);
                                },
                                errorText: 'Gender is required',
                              ),
                              if (product.category?.type != CategoryType.accessories) ...[
                                SizedBox(height: theme.spacing.inline.xs),
                                ChoiceSelectorWidget(
                                  choices: product.category?.type == CategoryType.clothing 
                                    ? productClothingSizes 
                                    : productShoeSizes,
                                  label: 'Size',
                                  tooltip: 'Select the size of the item',
                                  selectedId: state.product.size ?? '',
                                  onTap: (size) {
                                    context.read<BuilderProductCubit>().updateState(
                                          size: size,
                                        );
                                  },
                                ),
                              ],
                              SizedBox(height: theme.spacing.inline.sm),
                              CheckboxLabelWidget(
                                label: 'Flaws',
                                tooltip: 'Check if the item has any flaws',
                                isChecked: state.product.hasFlaws,
                                onTap: () {
                                  final hasFlaws = product.hasFlaws;
                                  context.read<BuilderProductCubit>().updateState(hasFlaws: !hasFlaws);
                                },
                              ),
                              if (product.hasFlaws) ...[
                                TextInputLabelWidget(
                                  label: 'Details',
                                  hintText: 'g.e., small stain mark, wash wear',
                                  tooltip: 'Include any flaws or imperfections',
                                  keyboardType: TextInputType.multiline,
                                  controller: flawsDetailsController,
                                  validator: (value) {
                                    if (product.hasFlaws && value?.isEmpty == true) {
                                      return 'Flaws are required';
                                    }

                                    return null;
                                  },
                                  maxLines: null,
                                  minLines: null,
                                  expands: true,
                                ),
                                SizedBox(height: theme.spacing.inline.xxs),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xxxs),
                                  child: DSText(
                                    'Please remember to upload images of the flaws described above along with general images of the item.',
                                    customStyle: TextStyle(
                                      fontSize: theme.font.size.xxxs,
                                      fontWeight: theme.font.weight.regular,
                                      color: theme.colors.neutral.dark.two,
                                    ),
                                  ),
                                ),
                              ],
                              SizedBox(height: theme.spacing.inline.xs),
                              if (product.category?.type == CategoryType.clothing) ...[
                                CheckboxLabelWidget(
                                  label: 'Tailored',
                                  tooltip: 'Check if the item has been custom tailored',
                                  isChecked: state.product.isTailored,
                                  onTap: () {
                                    final isTailored = product.isTailored;
                                    context.read<BuilderProductCubit>().updateState(isTailored: !isTailored);
                                  },
                                ),
                                if (product.isTailored) ...{
                                  TextInputLabelWidget(
                                    label: 'Details',
                                    hintText: 'e.g., Taken in at the waist, shortened sleeves',
                                    tooltip: 'Include any alterations or unique details',
                                    keyboardType: TextInputType.multiline,
                                    controller: detailsController,
                                    validator: (value) {
                                      if (product.isTailored && value?.isEmpty == true) {
                                        return 'Details are required';
                                      }

                                      return null;
                                    },
                                    maxLines: null,
                                    minLines: null,
                                    expands: true,
                                  ),
                                  SizedBox(height: theme.spacing.inline.sm),
                                },
                              ],
                              TextInputLabelWidget(
                                label: 'Price',
                                hintText: 'Min \$100 - Max \$2,000',
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                formatter: PriceInputFormatter(),
                                validator: (value) {
                                  if (value?.isEmpty == true) {
                                    return 'Price is required';
                                  } else if (value!.parseToDouble() < 100) {
                                    return 'Price must be greater than \$100';
                                  } else if (value.parseToDouble() > 2000) {
                                    return 'Price must be less than \$2,000';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  final price = value.parseToDouble();
                                  context.read<BuilderProductCubit>().updateState(price: price);
                                },
                              ),
                              if (!isUserMaster) ...[
                                SizedBox(height: theme.spacing.inline.xxs),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: theme.spacing.inline.xxs),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      DSText(
                                        CreateProductStrings.standartCommissionValueLabel,
                                        customStyle: TextStyle(
                                          fontSize: theme.font.size.xxxs,
                                          fontWeight: theme.font.weight.regular,
                                          color: theme.colors.neutral.dark.two,
                                        ),
                                      ),
                                      SizedBox(height: theme.spacing.inline.xxxs),
                                      DSText(
                                        CreateProductStrings.finalTakeHomeValueLabel(
                                          (product.price ?? 0).calculateStandartCommission().toCurrency(),
                                        ),
                                        customStyle: TextStyle(
                                          fontSize: theme.font.size.xxxs,
                                          fontWeight: theme.font.weight.regular,
                                          color: theme.colors.neutral.dark.two,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              SizedBox(height: theme.spacing.inline.xs),
                              if (isUserMaster) ...[
                                SellerUserSelectionWidget(
                                  seller: state.product.seller,
                                ),
                                SizedBox(height: theme.spacing.inline.xs),
                              ],
                              const ThemeDividerWidget(),
                              SizedBox(height: theme.spacing.inline.xs),
                              BlocConsumer<CreateProductCubit, CreateProductState>(
                                listener: (context, state) {
                                  if (state is CreateProductSuccess) {
                                    widget.appNavigator.pushNamedAndRemoveUntil(Routes.main);
                                    ScaffoldMessenger.of(context).showSuccessSnackBar(
                                      context,
                                      content: isEditing ? CreateProductStrings.editProductSuccess : CreateProductStrings.createProductSuccess,
                                    );
                                  } else if (state is CreateProductError) {
                                    showDSBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      child: ErrorBottomSheetWidget(
                                        message: state.message,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return DSButton(
                                    label: !isEditing ? CreateProductStrings.createProduct : CreateProductStrings.editProduct,
                                    onPressed: () {
                                      if (product.images == null || product.images!.isEmpty) {
                                        showDSBottomSheet(
                                          context: context,
                                          isScrollControlled: false,
                                          child: const ErrorBottomSheetWidget(
                                            message: 'You must add at least one image to the product.',
                                          ),
                                        );
                                        return;
                                      } 
                                      
                                      if (formKey.currentState!.validate()) {
                                        if (isEditing) {
                                          context.read<CreateProductCubit>().updateProduct(
                                                id: widget.id!,
                                                title: titleController.text,
                                                description: descriptionController.text,
                                                price: product.price,
                                                tag: product.tag,
                                                images: product.images,
                                                brand: brandController.text,
                                                isTailored: product.isTailored,
                                                details: product.isTailored ? detailsController.text : null,
                                                flaws: product.hasFlaws ? flawsDetailsController.text : null,
                                                gender: product.gender?.value,
                                                size: product.size,
                                              );
                                        } else {
                                          context.read<CreateProductCubit>().createProduct(
                                                title: titleController.text,
                                                description: descriptionController.text,
                                                price: product.price,
                                                category: widget.category,
                                                tag: product.tag,
                                                images: product.images,
                                                brand: brandController.text,
                                                isTailored: product.isTailored,
                                                details: product.isTailored ? detailsController.text : null,
                                                flaws: product.hasFlaws ? flawsDetailsController.text : null,
                                                gender: product.gender?.value,
                                                sellerId: product.seller?.id,
                                                size: product.size,
                                              );
                                        }
                                      }
                                    },
                                    isLoading: state is CreateProductLoading,
                                    size: DSButtonSize.md,
                                    type: DSButtonType.secondary,
                                  );
                                },
                              ),
                              SizedBox(height: theme.spacing.inline.xxs),
                              if (!isEditing) ...{
                                const TermsAgreementWidget(),
                              },
                              SizedBox(height: theme.spacing.inline.sm),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
