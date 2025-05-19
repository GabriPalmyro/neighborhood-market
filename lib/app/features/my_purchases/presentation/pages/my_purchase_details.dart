import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/fade_switcher/fade_switcher_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/topbar/topbar.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/main/presentation/widgets/main_page_error_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/cubit/purchase_details_cubit.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/purchase_details_loading_widget.dart';
import 'package:neighborhood_market/app/features/my_purchases/presentation/widgets/purchase_details_success_widget.dart';

class PurchaseDetailsPage extends StatelessWidget {
  const PurchaseDetailsPage({required this.purchaseId, super.key});

  final String purchaseId;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Scaffold(
      appBar: TopbarWidget.defaultTopBar(
        centerTitle: false,
        title: DSText(
          'Details',
          customStyle: TextStyle(
            fontSize: theme.font.size.xs,
            fontWeight: theme.font.weight.bold,
          ),
        ),
      ),
      backgroundColor: theme.colors.neutral.light.background,
      body: BlocBuilder<PurchaseDetailsCubit, PurchaseDetailsState>(
        builder: (context, state) {
          return FadeSwitcher(
            child: () {
              if (state is PurchaseDetailsLoading) {
                return const PurchaseDetailsLoadingWidget();
              } else if (state is PurchaseDetailsLoaded) {
                return PurchaseDetailsSuccessWidget(
                  purchaseId: purchaseId,
                  purchaseDetails: state.purchase,
                );
              } else {
                return MainPageErrorWidget(
                  onRetry: () {
                    context.read<PurchaseDetailsCubit>().loadPurchaseDetails(
                          purchaseId,
                        );
                  },
                );
              }
            }(),
          );
        },
      ),
    );
  }
}
