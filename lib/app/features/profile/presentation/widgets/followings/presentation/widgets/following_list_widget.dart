import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/followings/presentation/widgets/following_list_loading_widget.dart';
import 'package:neighborhood_market/app/features/profile/presentation/widgets/followings/presentation/widgets/following_list_success_widget.dart';

class FollowingListWidget extends StatelessWidget {
  const FollowingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (_) => GetIt.I.get<FollowingsCubit>()
        ..getFollowings(limit: 10)
        ..listenToUpdateEvents(),
      child: BlocBuilder<FollowingsCubit, FollowingsState>(
        builder: (context, state) {
          return FadeSwitcherState<FollowingsState, FollowingsLoaded, FollowingsError, FollowingsLoading>(
            error: (_) => const SizedBox(),
            loading: (_) => const FollowingListLoadingWidget(),
            result: (result) {

              if (result.followings.isEmpty) {
                return const SizedBox();
              }

              return Padding(
              padding: EdgeInsets.only(
                top: theme.spacing.inline.xs,
              ),
              child: FollowingListSuccessWidget(
                followings: result.followings,
              ),
            );
            },
            state: state,
          );
        },
      ),
    );
  }
}
