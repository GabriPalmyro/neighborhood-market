import 'package:equatable/equatable.dart';

abstract class ComponentContentState extends Equatable {
  const ComponentContentState();

  @override
  List<Object> get props => [];
}

class ComponentContentInitial extends ComponentContentState {
  const ComponentContentInitial();
}

class ComponentContentLoading extends ComponentContentState {
  const ComponentContentLoading();
}

class ComponentContentLoaded extends ComponentContentState {
  const ComponentContentLoaded({
    required this.content,
  });

  final dynamic content;

  @override
  List<Object> get props => [content];
}

class ComponentContentError extends ComponentContentState {
  const ComponentContentError();
}
