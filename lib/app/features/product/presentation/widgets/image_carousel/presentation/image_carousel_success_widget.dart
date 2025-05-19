import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/image_full_view/image_full_view_cubit.dart';

class ImageCarouselSuccessWidget extends StatefulWidget {
  const ImageCarouselSuccessWidget({required this.images, super.key});
  final List<String> images;

  @override
  State<ImageCarouselSuccessWidget> createState() => _ImageCarouselSuccessWidgetState();
}

class _ImageCarouselSuccessWidgetState extends State<ImageCarouselSuccessWidget> {
  late CarouselSliderController carouselController;

  @override
  void initState() {
    carouselController = CarouselSliderController();
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const double height = 350.0;
    const double aspectRatio = 1.0;
    final theme = DSTheme.getDesignTokensOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                onPageChanged: (index, _) => setState(() => currentIndex = index),
                height: height,
                aspectRatio: aspectRatio,
                viewportFraction: aspectRatio,
                enableInfiniteScroll: false,
              ),
              items: widget.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ImageFullViewCubit>().changeImageIndex(currentIndex);
                        context.read<ImageFullViewCubit>().changeImageFullView();
                      },
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Container(
                            width: double.infinity,
                            color: theme.colors.neutral.light.one,
                            child: DSIcon(
                              icon: DSIcons.camera,
                              color: theme.colors.neutral.light.icon,
                              size: DSIconSize.lg,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(theme.borders.radius.large),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xxs,
                  vertical: theme.spacing.inline.xxxs,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DSIcon(
                      icon: DSIcons.camera,
                      size: DSIconSize.sm,
                      color: theme.colors.neutral.light.pure,
                    ),
                    SizedBox(width: theme.spacing.inline.xxs),
                    DSText(
                      '${currentIndex + 1}/${widget.images.length}',
                      customStyle: TextStyle(
                        color: theme.colors.neutral.light.pure,
                        fontSize: theme.font.size.xxxs,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: theme.spacing.inline.xxs,
            left: theme.spacing.inline.xs,
          ),
          child: DSText(
            'Click on the image to view full screen',
            customStyle: TextStyle(
              fontSize: theme.font.size.xxxs,
              color: theme.colors.neutral.light.icon,
            ),
          ),
        ),
      ],
    );
  }
}
