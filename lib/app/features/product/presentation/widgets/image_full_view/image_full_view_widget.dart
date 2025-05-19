// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/product/presentation/cubit/image_full_view/image_full_view_cubit.dart';
import 'package:photo_view/photo_view.dart';

class ImageFullViewWidget extends StatefulWidget {
  const ImageFullViewWidget({
    required this.images,
    this.initialIndex = 0,
    super.key,
  });

  final List<String> images;
  final int initialIndex;

  @override
  State<ImageFullViewWidget> createState() => _ImageFullViewWidgetState();
}

class _ImageFullViewWidgetState extends State<ImageFullViewWidget> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final tokens = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<ImageFullViewCubit, ImageFullViewState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ImageFullViewCubit>().changeImageFullView();
                },
                child: Container(
                  color: Colors.black.withOpacity(.6), // Black background with opacity
                ),
              ),
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: widget.images.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  aspectRatio: 1.0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  initialPage: widget.initialIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      context.read<ImageFullViewCubit>().changeImageIndex(index);
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return PhotoView(
                    imageProvider: NetworkImage(
                      widget.images[index],
                    ),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  );
                },
              ),
              if (state.currentIndex != 0) ...[
                Positioned(
                  left: 10,
                  top: MediaQuery.of(context).size.height / 2 - 25,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      _controller.animateToPage(state.currentIndex - 1);
                    },
                  ),
                ),
              ],
              if (state.currentIndex != widget.images.length - 1) ...[
                Positioned(
                  right: 10,
                  top: MediaQuery.of(context).size.height / 2 - 25,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      _controller.animateToPage(state.currentIndex + 1);
                    },
                  ),
                ),
              ],
              Positioned(
                top: 10 + MediaQuery.of(context).padding.top,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: tokens.colors.neutral.light.pure,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: tokens.colors.neutral.dark.icon,
                    ),
                    onPressed: () {
                      context.read<ImageFullViewCubit>().changeImageFullView();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
