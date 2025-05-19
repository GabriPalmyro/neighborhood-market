import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/network/network_provider.dart';
import 'package:neighborhood_market/app/features/white_glove/domain/boundary/white_glove_repository.dart';
import 'package:neighborhood_market/app/features/white_glove/domain/entity/white_glove_item_entity.dart';

@Injectable(as: WhiteGloveRepository)
class WhiteGloveRepositoryImpl implements WhiteGloveRepository {
  WhiteGloveRepositoryImpl({required this.provider});
  final NetworkProvider provider;
  @override
  Future<void> requestWhiteGlove(
    List<WhiteGloveItemEntity> items,
  ) async {
    final network = await provider.getNetworkInstance();

    await network.post(
      '/white-glove-listing',
      data: {
        'requests': items.map((e) => e.toJson()).toList(),
      },
    );
  }
}
