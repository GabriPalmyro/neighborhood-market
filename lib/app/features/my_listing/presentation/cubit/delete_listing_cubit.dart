import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/reactive_listener/reactive_listener.dart';
import 'package:neighborhood_market/app/features/my_listing/data/event/refresh_listing_event.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/boundary/my_listing_repository.dart';

part 'delete_listing_state.dart';

@injectable
class DeleteListingCubit extends Cubit<DeleteListingState> {
  DeleteListingCubit(
    this.repository,
    this.reactiveListener,
  ) : super(const DeleteListingInitial());

  final MyListingRepository repository;
  final ReactiveListener reactiveListener;

  Future<void> deleteListingItem(String id) async {
    emit(const DeleteListingLoading());
    try {
      await repository.deleteListingItem(id: id);
      emit(const DeleteListingSuccess());
    } catch (e) {
      try {
        if (e is DioException) {
          emit(DeleteListingFailure(e.response?.data['message'] as String));
        } else {
          emit(const DeleteListingFailure('An error occurred while deleting the listing'));
        }
      } catch (_) {
        emit(const DeleteListingFailure('An error occurred while deleting the listing'));
      }
    }
  }

  void refreshListing() {
    reactiveListener.publish(const RefreshListingEvent());
  }
}
