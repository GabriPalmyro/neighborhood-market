part of 'builder_product_cubit.dart';

enum BuilderProductEvent {
  createProduct,
  editProduct;
}

sealed class BuilderProductState extends Equatable {
  const BuilderProductState();

  @override
  List<Object?> get props => [];
}

final class BuilderProductInitial extends BuilderProductState {
  const BuilderProductInitial();

  @override
  List<Object?> get props => [];
}

final class BuilderProductLoading extends BuilderProductState {
  const BuilderProductLoading();

  @override
  List<Object?> get props => [];
}

final class BuilderProductError extends BuilderProductState {
  const BuilderProductError();

  @override
  List<Object?> get props => [];
}

final class BuilderProductInfos extends BuilderProductState {
  const BuilderProductInfos({
    this.id,
    this.product = const CreateProductModel(),
    this.isInitialLoad = false,
  });

  final String? id;
  final CreateProductModel product;
  final bool isInitialLoad;

  bool get isEditing => id != null;

  BuilderProductInfos copyWith({
    String? id,
    CreateProductModel? product,
    bool? isInitialLoad,
  }) {
    return BuilderProductInfos(
      id: id,
      product: product ?? this.product,
      isInitialLoad: isInitialLoad ?? false
    );
  }

  @override
  List<Object?> get props => [id, product, isInitialLoad];
}
