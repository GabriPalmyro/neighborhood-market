import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/create_product/domain/boundary/create_product_repository.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/category_entity.dart';

part 'create_product_state.dart';

@injectable
class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit(this.repository) : super(const CreateProductInitial());

  final CreateProductRepository repository;

  Future<void> createProduct({
    String? title,
    String? description,
    double? price,
    CategoryEntity? category,
    String? tag,
    String? brand,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    String? flaws,
    String? gender,
    String? size,
    String? sellerId,
  }) async {
    emit(const CreateProductLoading());
    try {
      await repository.createProduct(
        title: title,
        description: description,
        price: price,
        category: category,
        tag: tag,
        images: images,
        brand: brand,
        isTailored: isTailored,
        details: details,
        flaws: flaws,
        gender: gender,
        size: size,
        sellerId: sellerId,
      );
      emit(const CreateProductSuccess());
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      emit(CreateProductError(message: message));
    }
  }

  Future<void> updateProduct({
    required String id,
    String? title,
    String? description,
    double? price,
    // String? category,
    String? tag,
    String? brand,
    List<Uint8List>? images,
    bool? isTailored,
    String? details,
    String? flaws,
    String? gender,
    String? size,
  }) async {
    emit(const CreateProductLoading());
    try {
      await repository.updateProduct(
        id: id,
        title: title,
        description: description,
        price: price,
        // category: category,
        tag: tag,
        brand: brand,
        images: images,
        isTailored: isTailored,
        details: details,
        size: size,
        flaws: flaws,
        gender: gender,
      );
      emit(const CreateProductSuccess());
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      emit(CreateProductError(message: message));
    }
  }
}
