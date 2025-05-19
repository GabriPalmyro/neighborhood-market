import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/white_glove/presentation/cubit/white_glove_cubit.dart';
import 'package:neighborhood_market/app/features/white_glove/presentation/page/white_glove_delivery_bottom_sheet.dart';
import 'package:neighborhood_market/app/features/white_glove/utils/white_glove_strings.dart';

class WhiteGloveDeliveryWidget extends StatelessWidget {
  const WhiteGloveDeliveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: theme.spacing.inline.xs,
        horizontal: theme.spacing.inline.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSText(
            WhiteGloveStrings.whiteGloveListingService(0),
            customStyle: TextStyle(
              fontSize: theme.font.size.xs,
              fontWeight: theme.font.weight.semiBold,
              color: theme.colors.neutral.dark.three,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xs),
          DSText(
            WhiteGloveStrings.whiteGloveListingServiceDescription,
            customStyle: TextStyle(
              fontSize: theme.font.size.xs,
              color: theme.colors.neutral.dark.pure,
            ),
          ),
          SizedBox(height: theme.spacing.inline.xs),
          DSButton(
            label: 'Request Service',
            type: DSButtonType.secondary,
            size: DSButtonSize.md,
            onPressed: () {
              showDSBottomSheet(
                context: context,
                isScrollControlled: true,
                child: BlocProvider(
                  create: (context) => GetIt.I.get<WhiteGloveCubit>(),
                  child: const WhiteGloveDeliveryBottomSheet(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
