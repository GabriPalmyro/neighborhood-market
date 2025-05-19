import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network.dart';
import 'package:neighborhood_market/app/features/manage_cards/data/model/manage_cards_model.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/boundary/manage_cards_repository.dart';
import 'package:neighborhood_market/app/features/manage_cards/domain/entities/manage_cards_entity.dart';

@Injectable(as: ManageCardsRepository)
class ManageCardsRepositoryImpl implements ManageCardsRepository {
  ManageCardsRepositoryImpl({required this.provider});

  final NetworkProvider provider;

  @override
  Future<ManageCardsEntity> getManageCards({required String userId}) async {
    final network = await provider.getNetworkInstance();

    final response = await network.get(
      '/manage-cards',
      queryParameters: {
        'userId': userId,
      },
    );

    return ManageCardsModel.fromJson(response.data).toEntity();
  }
}
