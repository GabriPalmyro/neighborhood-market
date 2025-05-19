import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/widgets/cancel_listing_confirmation_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/product/presentation/widgets/product_action_button/presentation/cubit/offer_cubit.dart';

class ListingActionsBottomSheet extends StatelessWidget {
  const ListingActionsBottomSheet({
    required this.productId,
    required this.appNavigator,
    super.key,
  });

  final String productId;
  final AppNavigator appNavigator;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (_) => GetIt.I.get<OfferCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.sm,
          theme.spacing.inline.xs,
          theme.spacing.inline.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSButton(
              label: 'Edit Item',
              type: DSButtonType.primaryOutline,
              onPressed: () async {
                appNavigator.pop();
                appNavigator.pushRoute(
                  Routes.createProduct,
                  queryParameters: {
                    'id': productId,
                  },
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSButton(
              label: 'Cancel Item',
              onPressed: () async {
                appNavigator.pop();
                showDSBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  child: CancelListingConfirmationBottomSheet(
                    productId: productId,
                  ),
                );
              },
            ),
            SizedBox(height: theme.spacing.inline.xxs),
          ],
        ),
      ),
    );
  }
}
