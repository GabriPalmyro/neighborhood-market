import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:neighborhood_market/app/features/notifications/presentation/widgets/notification_card/notification_card_widget.dart';
import 'package:neighborhood_market/app/features/notifications/utils/notifications_strings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({required this.appNavigator, super.key});
  final AppNavigator appNavigator;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      backgroundColor: theme.colors.neutral.light.background,
      appBar: TopbarWidget.defaultTopBar(
        title: DSText(
          NotificationsStrings.title,
          customStyle: TextStyle(
            fontWeight: theme.font.weight.semiBold,
          ),
        ),
        centerTitle: false,
        // actions: [
        //   ClickableWidget(
        //     borderRadius: BorderRadius.circular(
        //       theme.borders.radius.medium,
        //     ),
        //     onTap: () {},
        //     child: Padding(
        //       padding: EdgeInsets.all(theme.spacing.stack.xxs),
        //       child: DSText(
        //         'Clear All',
        //         customStyle: TextStyle(
        //           fontSize: theme.font.size.xxs,
        //         ),
        //       ),
        //     ),
        //   ),
        //   SizedBox(width: theme.spacing.inline.xxs),
        // ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return FadeSwitcherState<NotificationsState, NotificationsLoaded, NotificationsError, NotificationsLoading>(
            state: state,
            error: (_) => MainPageErrorWidget(
              onRetry: () {
                context.read<NotificationsCubit>().getNotifications();
              },
            ),
            loading: (_) => const Center(child: LoadingWidget()),
            result: (result) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.inline.xs,
                ),
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () async {
                    await context.read<NotificationsCubit>().getNotifications();
                    _refreshController.refreshCompleted();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: result.notifications.length,
                          (context, index) {
                            final notification = result.notifications[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                top: index == 0 ? theme.spacing.stack.xs : 0,
                                bottom: theme.spacing.stack.xs,
                              ),
                              child: NotificationCardWidget(
                                entity: notification,
                                appNavigator: widget.appNavigator,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
