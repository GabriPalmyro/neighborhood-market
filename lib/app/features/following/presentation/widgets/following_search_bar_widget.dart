import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/core/support/icons/icons.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart';
import 'package:neighborhood_market/app/features/home/presentation/widgets/search_bar/presentation/widget/search_success_widget.dart';

class FollowingSearchBarWidget extends StatelessWidget {
  const FollowingSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      backgroundColor: theme.colors.neutral.light.pure,
      surfaceTintColor: theme.colors.neutral.light.pure,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colors.neutral.light.icon,
              width: theme.borderWidth.thin,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.inline.xs,
            vertical: theme.spacing.inline.xs,
          ),
          child: BlocBuilder<FollowingsCubit, FollowingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SearchSuccessWidget(
                          label: 'Search',
                          showClearButton: false,
                          leadingIcon: DSIcons.search,
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          onSubmitted: (query) {
                            if (query?.isNotEmpty == true) {
                              context.read<FollowingsCubit>().searchFollowings(query!);
                            }
                          },
                          enabled: state is! FollowingsLoading,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
