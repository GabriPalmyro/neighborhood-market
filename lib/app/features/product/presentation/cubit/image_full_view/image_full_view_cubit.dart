import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'image_full_view_state.dart';

@injectable
class ImageFullViewCubit extends Cubit<ImageFullViewState> {
  ImageFullViewCubit() : super(const ImageFullViewState());

  void changeImageFullView() {
    emit(
      state.copyWith(
        isImageFullView: !state.isImageFullView,
      ),
    );
  }

  void changeImageIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }
}
