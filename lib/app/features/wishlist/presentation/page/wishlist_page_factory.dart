import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:neighborhood_market/app/features/wishlist/presentation/page/wishlist_page.dart';

class WishlistPageFactory extends ComponentsPageFactory {
  WishlistPageFactory();

  late WishlistCubit _cubit;

  void addWishlistCubit(WishlistCubit cubit) {
    _cubit = cubit;
  }

  @override
  void addAdapter(ComponentContentAdapter adapter) {
    this.adapter = adapter;
  }

  @override
  Widget create([params]) {
    return BlocProvider(
      create: (_) => _cubit
        ..listenToWishlistEvents()
        ..getResult(),
      child: const WishlistPage(),
    );
  }
}
