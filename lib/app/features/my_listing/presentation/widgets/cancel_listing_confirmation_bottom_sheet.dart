import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_listing/presentation/cubit/delete_listing_cubit.dart';

class CancelListingConfirmationBottomSheet extends StatelessWidget {
  const CancelListingConfirmationBottomSheet({
    required this.productId,
    super.key,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (_) => GetIt.I.get<DeleteListingCubit>(),
      child: BlocConsumer<DeleteListingCubit, DeleteListingState>(
        listener: (context, state) {
          if (state is DeleteListingSuccess) {
            context.read<DeleteListingCubit>().refreshListing();
            Navigator.of(context).pop();
          } else if (state is DeleteListingFailure) {
            final message = state.message;
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showDSSnackBar(
              context,
              type: SnackBarType.error,
              content: DSText(
                message,
                customStyle: TextStyle(
                  color: theme.colors.neutral.light.pure,
                  fontSize: theme.font.size.xxs,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              theme.spacing.inline.xs,
              theme.spacing.inline.sm,
              theme.spacing.inline.xs,
              theme.spacing.inline.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DSText(
                  'Are you sure?',
                  customStyle: TextStyle(
                    fontSize: theme.font.size.xs,
                    fontWeight: theme.font.weight.bold,
                  ),
                ),
                SizedBox(height: theme.spacing.inline.xs),
                DSButton(
                  label: 'Confirm',
                  isLoading: state is DeleteListingLoading,
                  onPressed: () {
                    context.read<DeleteListingCubit>().deleteListingItem(productId);
                  },
                ),
                SizedBox(height: theme.spacing.inline.xxs),
                DSButton(
                  label: 'Back',
                  type: DSButtonType.primaryOutline,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: theme.spacing.inline.xxs),
              ],
            ),
          );
        },
      ),
    );
  }
}
