import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/boundary/manage_cards_repository.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/manage_cards_entity.dart';

part 'manage_cards_state.dart';

@injectable
class ManageCardsCubit extends Cubit<ManageCardsState> {
  ManageCardsCubit(this.repository) : super(const ManageCardsInitial());

  final ManageCardsRepository repository;

  Future<void> getManageCards({
    required String userId,
  }) async {
    emit(const ManageCardsLoading());
    try {
      final entity = await repository.getManageCards(userId: userId);
      emit(ManageCardsLoaded(entity));
    } catch (e) {
      emit(const ManageCardsError());
    }
  }
}
