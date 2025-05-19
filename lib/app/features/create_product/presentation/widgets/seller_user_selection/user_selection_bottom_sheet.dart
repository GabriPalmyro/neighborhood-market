import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/shimmer/shimmer_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/extensions/scroll_mixin.dart';
import 'package:neighborhood_market/app/features/create_product/domain/entity/user_search_entity.dart';
import 'package:neighborhood_market/app/features/create_product/presentation/cubit/user_selection/user_selection_cubit.dart';
import 'package:neighborhood_market/app/features/explore/presentation/widgets/bottom_loader/bottom_loader_widget.dart';

class UserSelectionBottomSheet extends StatefulWidget {
  const UserSelectionBottomSheet({required this.onSelected, super.key});

  final Function(UserSearchEntity) onSelected;

  @override
  State<UserSelectionBottomSheet> createState() => _UserSelectionBottomSheetState();
}

class _UserSelectionBottomSheetState extends State<UserSelectionBottomSheet> with ScrollMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;

  @override
  void initState() {
    context.read<UserSelectionCubit>().searchUsers('');
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  ScrollController get scrollController => _scrollController;

  void _search(String query) {
    _searchFocusNode.unfocus();
    context.read<UserSelectionCubit>().searchUsers(query);
  }

  Future<void> _onScroll() async {
    final state = context.read<UserSelectionCubit>().state;

    if (state is UserSelectionLoading) {
      return;
    }

    if (isBottom && state is UserSelectionLoaded && !state.hasReachedMax) {
      context.read<UserSelectionCubit>().loadMore();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 700), () {
      _search(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocBuilder<UserSelectionCubit, UserSelectionState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                ).copyWith(
                  top: theme.spacing.inline.xs,
                ),
                child: DSTextField(
                  label: 'Search username',
                  hintText: 'Search',
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  focusNode: _searchFocusNode,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: _search,
                  suffixWidget: _searchController.value.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            _search('');
                            _searchFocusNode.unfocus();
                          },
                        )
                      : null,
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state is UserSelectionLoading) {
                      return ListView(
                        children: List.generate(
                          10,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.inline.xs,
                            ).copyWith(
                              top: theme.spacing.inline.xs,
                            ),
                            child: const ShimmerComponent(
                              width: double.infinity,
                              height: 60,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is UserSelectionError) {
                      return Center(
                        child: DSText(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (state is UserSelectionInitial) {
                      return const Center(
                        child: DSText('No users found'),
                      );
                    }

                    final users = (state as UserSelectionLoaded).users;

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: users.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final currentState = context.read<UserSelectionCubit>().state as UserSelectionLoaded;
                        final isLoadingMore = currentState.isLoadingMore && index == users.length - 1;
                        return Column(
                          children: [
                            ListTile(
                              title: DSText(user.name),
                              subtitle: DSText(
                                user.email,
                                customStyle: TextStyle(
                                  fontSize: theme.font.size.xxxs,
                                  fontWeight: theme.font.weight.regular,
                                  color: theme.colors.neutral.dark.two,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                widget.onSelected(user);
                              },
                            ),
                            if (isLoadingMore)
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: theme.spacing.inline.xs,
                                ),
                                child: const BottomLoader()
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: theme.spacing.inline.md),
            ],
          ),
        );
      },
    );
  }
}
