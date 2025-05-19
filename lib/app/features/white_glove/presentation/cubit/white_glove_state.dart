part of 'white_glove_cubit.dart';

enum WhiteGloveStatus { initial, loading, loaded, error }

class WhiteGloveState extends Equatable {
  const WhiteGloveState({
    this.items = const [],
    this.status = WhiteGloveStatus.initial,
  });

  final List<WhiteGloveItemEntity> items;
  final WhiteGloveStatus status;

  WhiteGloveState copyWith({
    List<WhiteGloveItemEntity>? items,
    WhiteGloveStatus? status,
  }) {
    return WhiteGloveState(
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        items,
        status,
      ];
}
