part of 'image_full_view_cubit.dart';

final class ImageFullViewState extends Equatable {
  const ImageFullViewState({
    this.isImageFullView = false,
    this.currentIndex = 0,
  });

  final bool isImageFullView;
  final int currentIndex;

  ImageFullViewState copyWith({
    bool? isImageFullView,
    int? currentIndex,
  }) {
    return ImageFullViewState(
      isImageFullView: isImageFullView ?? this.isImageFullView,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [
        isImageFullView,
        currentIndex,
      ];
}
