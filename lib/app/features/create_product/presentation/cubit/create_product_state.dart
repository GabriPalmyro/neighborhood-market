part of 'create_product_cubit.dart';

sealed class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object> get props => [];
}

final class CreateProductInitial extends CreateProductState {
  const CreateProductInitial();

  @override
  List<Object> get props => [];
}

final class CreateProductLoading extends CreateProductState {
  const CreateProductLoading();

  @override
  List<Object> get props => [];
}

final class CreateProductSuccess extends CreateProductState {
  const CreateProductSuccess();

  @override
  List<Object> get props => [];
}

final class CreateProductError extends CreateProductState {
  const CreateProductError({this.message = ''});
  final String message;

  @override
  List<Object> get props => [message];
}
