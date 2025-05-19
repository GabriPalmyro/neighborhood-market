import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/my_purchases/purchases_completed_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/my_purchases/purchases_in_progress_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/utils/my_purchases_strings.dart';

class MyPurchasesPage extends StatelessWidget {
  const MyPurchasesPage({required this.appNavigator, super.key});

  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          MyPurchasesStrings.myPurchases,
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: theme.colors.neutral.light.two,
              labelColor: theme.colors.brand.secondary,
              indicatorColor: theme.colors.brand.secondary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: MyPurchasesStrings.inProgress),
                Tab(text: MyPurchasesStrings.completed),
              ],
            ),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colors.neutral.light.background,
                ),
                child: TabBarView(
                  children: [
                    PurchasesInProgressWidget(
                      appNavigator: appNavigator,
                    ),
                    PurchasesCompletedWidget(
                      appNavigator: appNavigator,
                    ),
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
