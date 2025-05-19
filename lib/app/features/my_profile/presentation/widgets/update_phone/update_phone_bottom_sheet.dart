import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/bottom_sheet/bottom_sheet_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_email_phone/update_email_phone_cubit.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_phone/verify_phone_bottom_sheet.dart';

class UpdatePhoneBottomSheet extends StatefulWidget {
  const UpdatePhoneBottomSheet({super.key});

  @override
  State<UpdatePhoneBottomSheet> createState() => _UpdatePhoneBottomSheetState();
}

class _UpdatePhoneBottomSheetState extends State<UpdatePhoneBottomSheet> {
  final TextEditingController _newPhoneController = TextEditingController();

  @override
  void dispose() {
    _newPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return BlocProvider(
      create: (context) => GetIt.I.get<UpdateEmailPhoneCubit>(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          theme.spacing.inline.xs,
          MediaQuery.of(context).viewInsets.bottom + theme.spacing.inline.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DSText(
              'Update Phone Number',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'Please enter your current phone number and provide a new phone number to update your account information.',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            TextInputLabelWidget(
              label: 'Enter your new phone number',
              hintText: 'Enter',
              controller: _newPhoneController,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: TextInputType.phone,
              prefixWidget: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.borders.radius.circular),
                    bottomLeft: Radius.circular(theme.borders.radius.circular),
                  ),
                  border: Border(
                    right: BorderSide(
                      color: theme.colors.neutral.light.three,
                      width: theme.borders.width.thick,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: theme.spacing.inline.xs,
                  right: theme.spacing.inline.xs,
                ),
                margin: EdgeInsets.only(
                  right: theme.spacing.inline.xxs,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DSText(
                      '+1',
                      customStyle: TextStyle(
                        fontSize: theme.font.size.xs,
                        color: theme.colors.neutral.dark.one,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(
              'Make sure your new email address is valid and accessible. This will be used for account communications and recovery.',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxxs,
                color: theme.colors.neutral.dark.two,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xs),
            Row(
              children: [
                Expanded(
                  child: DSButton(
                    label: 'Cancel',
                    onPressed: () {
                      GetIt.I.get<AppNavigator>().pop();
                    },
                    type: DSButtonType.ghost,
                  ),
                ),
                SizedBox(width: theme.spacing.inline.xs),
                BlocConsumer<UpdateEmailPhoneCubit, UpdateEmailPhoneState>(
                  listener: (context, state) {
                    if ((state as UpdateEmailPhoneInitial).status == UpdateEmailPhoneStatus.codeSent) {
                      Navigator.of(context).pop();
                      showDSBottomSheet(
                        context: context,
                        child: const VerifyPhoneBottomSheet(),
                      );
                    } else if (state.status == UpdateEmailPhoneStatus.error) {
                      ScaffoldMessenger.of(context).showErrorSnackBar(
                        context,
                        content: 'Error sending code. Please try again.',
                      );
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: DSButton(
                        label: 'Next',
                        onPressed: () {
                          Navigator.of(context).pop();
                          showDSBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            child: const VerifyPhoneBottomSheet(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: theme.spacing.inline.xxs),
          ],
        ),
      ),
    );
  }
}
