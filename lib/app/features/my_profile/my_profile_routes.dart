import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/my_profile_cubit.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/page/my_profile_page.dart';

final myProfileRoutes = [
  PageRoute(
    route: Routes.myProfile,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => BlocProvider(
      create: (_) => GetIt.I.get<MyProfileCubit>()..getMyProfile(),
      child: const MyProfilePage(),
    ),
  ),
  PageRoute(
    route: Routes.updatePassword,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => const MyProfilePage(),
  ),
];
