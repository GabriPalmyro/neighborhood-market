import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/images/image.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/images/images.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/filters/domain/model/filters_model.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart';

class FilterSuccessWidget extends StatelessWidget {
  const FilterSuccessWidget({
    required this.model,
    super.key,
  });

  final FiltersModel model;

  @override
  Widget build(BuildContext context) {
    const filterImageHeight = 52.0;
    final tokens = DSTheme.getDesignTokensOf(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.inline.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DSText(
                model.title ?? '',
                customStyle: TextStyle(
                  fontWeight: tokens.font.weight.semiBold,
                  fontSize: tokens.font.size.xs,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<MainPageCubit>().changePage(1);
                  GetIt.I.get<AppNavigator>().pushRoute(Routes.filterCategory);
                },
                child: DSText(
                  model.actionLabel ?? '',
                  customStyle: TextStyle(
                    fontWeight: tokens.font.weight.semiBold,
                    fontSize: tokens.font.size.xs,
                    color: tokens.colors.neutral.light.icon,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: tokens.spacing.inline.xs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: model.items?.map((item) {
                  return ClickableWidget(
                    borderRadius: BorderRadius.circular(tokens.borders.radius.small),
                    onTap: () {

                      if(item.type == 'gender') {
                        context.read<HomeCubit>().sendGender(item.value ?? '');
                      } else if(item.type == 'category') {
                        context.read<HomeCubit>().sendCategory(item.value ?? '');
                      }

                      context.read<MainPageCubit>().changePage(1);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.inline.xs,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: filterImageHeight,
                            width: filterImageHeight,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: tokens.colors.neutral.dark.pure.withValues(alpha: 0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(tokens.borders.radius.circular),
                              child: ThemeImage(
                                ThemeImages.fromString(item.image ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: tokens.spacing.inline.xxxs),
                          DSText(
                            item.label ?? '',
                            customStyle: TextStyle(
                              fontSize: tokens.font.size.xxs,
                              fontWeight: tokens.font.weight.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ],
    );
  }
}
