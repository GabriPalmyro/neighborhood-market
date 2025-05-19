import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/page/explore_page.dart';

class ExplorePageFactory extends ComponentsPageFactory {
  ExplorePageFactory();

  late ExploreCubit _cubit;

  void addExploreCubit(ExploreCubit cubit) {
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
        ..listenToFilterEvents()
        ..getProducts(),
      child: const ExplorePage(),
    );
  }
}
