import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/create_product/data/error/camera_permission_denied_error.dart';
import 'package:neighborhood_market/app/features/create_product/data/model/create_product_model.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';
import 'package:neighborhood_market/app/features/create_product/utils/product_conditions.dart';
import 'package:permission_handler/permission_handler.dart';

part 'builder_product_state.dart';

@injectable
class BuilderProductCubit extends Cubit<BuilderProductState> {
  BuilderProductCubit(this.repository) : super(const BuilderProductInfos());

  final CreateProductRepository repository;

  Future<void> getProduct(String? id) async {
    if (id == null) {
      return;
    }

    try {
      emit(const BuilderProductLoading());
      final item = await repository.getProduct(id);

      final List<Uint8List> images = List<Uint8List>.empty(growable: true);

      if (item.images != null && item.images!.isNotEmpty) {
        for (final imageUrl in item.images!) {
          final response = await HttpClient().getUrl(Uri.parse(imageUrl));
          final imageBytes = await consolidateHttpClientResponseBytes(await response.close());
          images.add(imageBytes);
        }
      }

      emit(
        BuilderProductInfos(
          id: id,
          isInitialLoad: true,
          product: CreateProductModel(
            title: item.title,
            description: item.description,
            price: item.price,
            tag: item.tags?.first,
            category: item.category,
            images: images,
            isTailored: item.isTailored,
            details: item.tailoredDetails,
            brand: item.brand,
            hasFlaws: item.flaws?.isNotEmpty == true,
            flaws: item.flaws,
            gender: item.gender,
            size: item.size,
          ),
        ),
      );
    } catch (e) {
      emit(const BuilderProductError());
    }
  }

  void updateState({
    String? title,
    String? description,
    double? price,
    List<String>? tags,
    CategoryEntity? category,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    bool? hasFlaws,
    String? flaws,
    String? size,
    UserSearchEntity? seller,
  }) {
    final currentState = state;
    if (currentState is BuilderProductInfos) {
      emit(
        currentState.copyWith(
          id: currentState.id,
          product: currentState.product.copyWith(
            title: title,
            description: description,
            price: price,
            tag: tags?.first,
            category: category,
            images: images,
            isTailored: isTailored,
            details: details,
            seller: seller,
            hasFlaws: hasFlaws,
            flaws: flaws,
            size: size,
          ),
        ),
      );
    }
  }

  void updateTagList(String tag) {
    final currentState = state;
    if (currentState is BuilderProductInfos) {
      emit(
        BuilderProductInfos(
          id: currentState.id,
          product: currentState.product.copyWith(
            tag: tag,
          ),
        ),
      );
    }
  }

  void updateGender(String gender) {
    final currentState = state;
    if (currentState is BuilderProductInfos) {
      emit(
        BuilderProductInfos(
          id: currentState.id,
          product: currentState.product.copyWith(
            gender: ProductGender.values.firstWhere(
              (element) => element.label == gender,
            ),
          ),
        ),
      );
    }
  }

  void clearState() {
    final currentCategory = (state as BuilderProductInfos).product.category;
    emit(
      BuilderProductInfos(
        id: (state as BuilderProductInfos).id,
        product: CreateProductModel(category: currentCategory),
      ),
    );
  }

  Future<bool> checkAndRequestCameraPermissions() async {
    // Request the permission directly to ensure the latest status

    final PermissionStatus status = await Permission.camera.status;

    // Check if the permission is already granted
    if (status.isGranted) {
      return true;
    }

    final PermissionStatus permission = await Permission.camera.request();

    // Check if the permission is granted
    if (permission == PermissionStatus.granted) {
      return true;
    }

    // If the permission is denied, show a message or guide the user to settings
    if (permission == PermissionStatus.denied || permission == PermissionStatus.permanentlyDenied) {
      // Inform the user that permission is required and guide to app settings
      return false;
    }

    return false;
  }

  Future<void> takePicture() async {
    final ImagePicker picker = ImagePicker();

    final bool hasPermission = await checkAndRequestCameraPermissions();

    if (!hasPermission) {
      throw CameraPermissionDeniedError();
    }

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        final File file = File(image.path);
        final fileSize = await file.length();
        if (fileSize > 5 * 1024 * 1024) {
          throw 'Each image must be less than 5MB';
        }

        final fileExtension = file.path.split('.').last;

        if (fileExtension != 'jpg' && fileExtension != 'jpeg' && fileExtension != 'png') {
          throw 'Only jpg, jpeg and png images are allowed';
        }

        final Uint8List imageBytes = await file.readAsBytes();

        final oldImages = (state as BuilderProductInfos).product.images ?? [];

        if (oldImages.length >= 5) {
          throw 'You can only upload up to 5 images';
        }

        final newImages = List<Uint8List>.from(oldImages)..add(imageBytes);

        updateState(images: newImages);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final oldImages = (state as BuilderProductInfos).product.images ?? [];

    // Pick multiple images.
    final List<XFile> images = await picker.pickMultiImage(
      limit: 5 - oldImages.length,
    );

    if (images.isNotEmpty) {
      final List<File> files = images.map((image) => File(image.path)).toList();

      for (final file in files) {
        final fileSize = await file.length();
        if (fileSize > 5 * 1024 * 1024) {
          throw 'Each image must be less than 5MB';
        }

        final fileExtension = file.path.split('.').last;

        if (fileExtension != 'jpg' && fileExtension != 'jpeg' && fileExtension != 'png') {
          throw 'Only jpg, jpeg and png images are allowed';
        }
      }

      final List<Uint8List> imageBytes = await Future.wait(
        files.map((file) => file.readAsBytes()),
      );

      if (imageBytes.length + oldImages.length > 5) {
        throw 'You can only upload up to 5 images';
      }

      final newImages = List<Uint8List>.from(oldImages)..addAll(imageBytes);

      updateState(images: newImages);
    }
  }

  void removeImage(int index) {
    final currentState = state;
    if (currentState is BuilderProductInfos) {
      final List<Uint8List> updatedImages = List.from(currentState.product.images ?? []);
      updatedImages.removeAt(index);
      emit(
        BuilderProductInfos(
          id: currentState.id,
          product: currentState.product.copyWith(
            images: updatedImages,
          ),
        ),
      );
    }
  }
}
