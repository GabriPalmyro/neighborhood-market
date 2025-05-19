import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/page/home_page.dart';

class HomePageFactory extends ComponentsPageFactory {
  HomePageFactory();

  late HomeCubit _cubit;

  void addHomeCubit(HomeCubit cubit) {
    _cubit = cubit;
  }

  @override
  void addAdapter(ComponentContentAdapter adapter) {
    this.adapter = adapter;
  }

  @override
  Widget create([params]) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _cubit..getResult(),
        ),
      ],
      child: HomePage(
        appNavigator: GetIt.I.get<AppNavigator>(),
      ),
    );
  }
}
