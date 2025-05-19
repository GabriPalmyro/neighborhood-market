import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/page_route.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/common/router/transition.dart';
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart';
import 'package:neighborhood_market/app/features/following/presentation/page/following_page.dart';

final followingRoutes = [
  PageRoute(
    route: Routes.following,
    transition: PageTransition.rightToLeft,
    builder: (_, __) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<FollowingsCubit>()..getFollowings(),
        ),
      ],
      child: const FollowingPage(),
    ),
  ),
];
