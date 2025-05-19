import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/error_bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/clickable/clickable_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/file_input/file_input_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/support/icon/icon_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/create_product/data/error/camera_permission_denied_error.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/builder_product_cubit.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/camera_permissions_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/widgets/select_image_input_widget.dart';

class ProductImagesWidget extends StatelessWidget {
  const ProductImagesWidget({
    required this.showAddButton,
    required this.images,
    super.key,
  });

  final bool showAddButton;
  final List<Uint8List> images;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    const maxAxisExtent = 200.0;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxAxisExtent,
        crossAxisSpacing: theme.spacing.inline.xxs,
        mainAxisSpacing: theme.spacing.inline.xxs,
      ),
      itemCount: showAddButton ? images.length + 1 : images.length,
      itemBuilder: (context, index) {
        // Se o índice for o último, exibe o botão de adicionar
        if (index == images.length && showAddButton) {
          return ClickableWidget(
            borderRadius: BorderRadius.circular(theme.borders.radius.large),
            onTap: () {
              showDSBottomSheet(
                context: context,
                child: SelectImageInputBottomSheet(
                  onPictureSelected: () {
                    context.read<BuilderProductCubit>().takePicture().then((_) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      if (error is CameraPermissionDeniedError) {
                        showDSBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          child: const CameraPermissionsBottomSheet(),
                        );
                        return;
                      }

                      showDSBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        child: ErrorBottomSheetWidget(
                          message: error.toString(),
                        ),
                      );
                    });
                  },
                  onGallerySelected: () {
                    context.read<BuilderProductCubit>().pickImage().then((_) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      showDSBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        child: ErrorBottomSheetWidget(
                          message: error.toString(),
                        ),
                      );
                    });
                  },
                ),
              );
            },
            child: const FileInputWidget(),
          );
        }

        // Exibe a imagem se não for o último índice
        return ClipRRect(
          borderRadius: BorderRadius.circular(theme.borders.radius.large),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.memory(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: theme.spacing.inline.xxs,
                right: theme.spacing.inline.xxs,
                child: GestureDetector(
                  onTap: () {
                    context.read<BuilderProductCubit>().removeImage(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.neutral.light.one,
                      borderRadius: BorderRadius.circular(theme.borders.radius.large),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(theme.spacing.inline.xxxs),
                      child: const Center(
                        child: DSIcon(
                          icon: DSIcons.close,
                          size: DSIconSize.xs,
                        ),
                      ),
                    ),
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
