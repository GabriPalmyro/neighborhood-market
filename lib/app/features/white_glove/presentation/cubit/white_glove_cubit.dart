import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/features/white_glove/domain/boundary/white_glove_repository.dart';
import 'package:neighborhood_market/app/features/white_glove/domain/entity/white_glove_item_entity.dart';

part 'white_glove_state.dart';

@injectable
class WhiteGloveCubit extends Cubit<WhiteGloveState> {
  WhiteGloveCubit(this.repository)
      : super(
          const WhiteGloveState(
            items: [WhiteGloveItemEntity()],
            status: WhiteGloveStatus.initial,
          ),
        );

  final WhiteGloveRepository repository;

  void addItem() {
    if (state.items.length < 10) {
      emit(state.copyWith(items: List.from(state.items)..add(const WhiteGloveItemEntity())));
    }
  }

  void removeItem(int index) {
    final updatedItems = List<WhiteGloveItemEntity>.from(state.items)..removeAt(index);
    emit(state.copyWith(items: updatedItems));
  }

  // Atualiza os dados de um convidado específico
  void updateItem(
    WhiteGloveItemEntity updatedItem,
    int index,
  ) {
    final updatedItems = List<WhiteGloveItemEntity>.from(state.items)..[index] = updatedItem;
    emit(state.copyWith(items: updatedItems));
  }

  Future<void> requestWhiteGlove() async {
    emit(state.copyWith(status: WhiteGloveStatus.loading));
    try {
      await repository.requestWhiteGlove(state.items);
      emit(state.copyWith(status: WhiteGloveStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: WhiteGloveStatus.error));
    }
  }
}
