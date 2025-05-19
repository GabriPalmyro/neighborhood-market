import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/domain/model/shop_galerry_model.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/shop_gallery/presentation/widgets/gallery_card/gallery_card_widget.dart';
import 'package:neighborhood_market/app/features/main/presentation/cubit/main_page_cubit.dart';

import '../../../../../../../common/design_system/core/theme/ds_theme.dart';

class ShopGallerySuccessWidget extends StatelessWidget {
  const ShopGallerySuccessWidget({
    required this.model,
    required this.navigator,
    this.onFavorite,
    super.key,
  });

  final ShopGalleryModel model;
  final AppNavigator navigator;
  final Function(String, bool)? onFavorite;

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    const double productHeight = 290.0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DSText(
              model.title ?? '',
              customStyle: TextStyle(
                fontWeight: tokens.font.weight.semiBold,
                fontSize: tokens.font.size.xs,
              ),
            ),
            if (model.actionLabel != null) ...[
              GestureDetector(
                onTap: () {
                  if (model.type?.name.isNotEmpty == true) {
                    context.read<HomeCubit>().sendSortBy(model.type!.name);
                    context.read<MainPageCubit>().changePage(1);
                  }
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
          ],
        ),
        SizedBox(height: tokens.spacing.inline.xxs),
        Wrap(
          spacing: tokens.spacing.inline.xxs,
          runSpacing: tokens.spacing.inline.xxs,
          alignment: WrapAlignment.start,
          children: List.generate(model.items.length, (index) {
            final item = model.items[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48 - tokens.spacing.inline.xs,
                  height: productHeight,
                  child: GalleryCardWidget(
                    item: item,
                    navigator: navigator,
                    onFavorite: (isLiked) {
                      onFavorite?.call(item.id, isLiked);
                    },
                  ),
                ),
                if (index == model.items.length - 1 && model.items.length % 2 != 0) ...[
                  const Spacer(),
                ],
              ],
            );
          }),
        ),
      ],
    );
  }
}
