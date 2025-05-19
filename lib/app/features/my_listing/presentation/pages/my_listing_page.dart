import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_state_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/loading/loading_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/my_listing/domain/entities/my_listing_type.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/cubit/my_listing_cubit.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/widgets/my_listing_list_widget.dart';
import 'package:neighborhood_market/app/features/my_listing/utils/my_listing_strings.dart';

class MyListingPage extends StatelessWidget {
  const MyListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          MyListingStrings.myListing,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: MyListingStrings.publishedTab),
                Tab(text: MyListingStrings.soldTab),
                Tab(text: MyListingStrings.canceledTab),
              ],
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.neutral.light.background,
                ),
                child: const TabBarView(
                  children: [
                    MyListingWidget(type: MyListingType.published),
                    MyListingWidget(type: MyListingType.sold),
                    MyListingWidget(type: MyListingType.canceled),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListingWidget extends StatefulWidget {
  const MyListingWidget({required this.type, super.key});

  final MyListingType type;

  @override
  MyListingWidgetState createState() => MyListingWidgetState();
}

class MyListingWidgetState extends State<MyListingWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => GetIt.I.get<MyListingCubit>()
        ..initRefreshListener(
          widget.type,
        )
        ..getMyListing(
          type: widget.type,
        ),
      child: BlocBuilder<MyListingCubit, MyListingState>(
        builder: (context, state) {
          return FadeSwitcherState<MyListingState, MyListingLoaded, MyListingError, MyListingLoading>(
            error: (_) => MainPageErrorWidget(
              onRetry: () {
                context.read<MyListingCubit>().getMyListing(type: widget.type);
              },
            ),
            loading: (_) => const Center(child: LoadingWidget()),
            result: (success) => MyListingListWidget(
              type: widget.type,
              list: success.list,
              key: ValueKey(widget.type.name),
              isValueCheck: widget.type != MyListingType.published,
            ),
            state: state,
          );
        },
      ),
    );
  }
}
