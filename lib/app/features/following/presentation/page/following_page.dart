import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/scroll_mixin.dart';
import 'package:neighborhood_market/app/features/following/presentation/cubit/followings_cubit.dart';
import 'package:neighborhood_market/app/features/following/presentation/widgets/following_card_widget.dart';
import 'package:neighborhood_market/app/features/following/presentation/widgets/following_loading_widget.dart';
import 'package:neighborhood_market/app/features/following/presentation/widgets/following_search_bar_widget.dart';
import 'package:neighborhood_market/app/features/following/utils/following_strings.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage({super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> with ScrollMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    final followingState = context.read<FollowingsCubit>().state;

    if (followingState is FollowingsLoaded && isBottom) {
      context.read<FollowingsCubit>().loadMoreFollowings();
    }
  }

  @override
  ScrollController get scrollController => _scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: theme.colors.neutral.light.background,
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          FollowingStrings.following,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const FollowingSearchBarWidget(),
          BlocBuilder<FollowingsCubit, FollowingsState>(
            builder: (context, state) {
              if (state is FollowingsInitial || state is FollowingsLoading) {
                return const FollowingLoadingWidget();
              }
              if (state is FollowingsLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = state.followings[index];
                      return FollowingCardWidget(following: item);
                    },
                    childCount: state.followings.length,
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: MainPageErrorWidget(
                    onRetry: () {
                      context.read<FollowingsCubit>().getFollowings();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
