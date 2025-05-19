import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/adapter/component_content_adapter.dart';
import 'package:neighborhood_market/app/common/component_builder/presentation/components_page_factory.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/page/profile_page.dart';

class ProfilePageFactory extends ComponentsPageFactory {
  ProfilePageFactory();

  late final AppNavigator appNavigator;
  late final ProfileCubit cubit;

  @override
  void addAdapter(ComponentContentAdapter adapter) {
    this.adapter = adapter;
  }

  void setProfileCubit(ProfileCubit cubit) {
    this.cubit = cubit;
  }

  void setAppNavigator(AppNavigator appNavigator) {
    this.appNavigator = appNavigator;
  }

  @override
  Widget create([params]) {
    return BlocProvider(
      create: (_) => cubit
        ..loadProfile()
        ..subscribeToProfileUpdates(),
      child: ProfilePage(
        appNavigator: appNavigator,
      ),
    );
  }
}
