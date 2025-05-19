
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter_builder.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/page/wishlist_page_factory.dart';

@module
abstract class WishlistModule {
  @Named('WishlistPageFactory')
  ComponentsPageFactory provideWishlistPageFactory(
    WishlistCubit cubit,
    ComponentContentAdapterBuilder adapterBuilder,
  ) {
    return WishlistPageFactory()
      ..addWishlistCubit(cubit)
      ..addAdapter(adapterBuilder.build());
  }
}
