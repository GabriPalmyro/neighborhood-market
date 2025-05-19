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
import 'package:neighborhood_market/app/features/my_profile/presentation/widgets/update_email/verify_email_bottom_sheet.dart';

class UpdateEmailBottomSheet extends StatefulWidget {
  const UpdateEmailBottomSheet({super.key});

  @override
  State<UpdateEmailBottomSheet> createState() => _UpdateEmailBottomSheetState();
}

class _UpdateEmailBottomSheetState extends State<UpdateEmailBottomSheet> {
  final TextEditingController _newEmailController = TextEditingController();

  @override
  void dispose() {
    _newEmailController.dispose();
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
              'Update Email',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'Please enter your current email address and provide a new email address to update your account information.',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            TextInputLabelWidget(
              label: 'Enter your new email',
              hintText: 'Enter',
              controller: _newEmailController,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              onChanged: (_) {
                setState(() {});
              },
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
                        child: const VerifyEmailBottomSheet(),
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
                        isLoading: (state as UpdateEmailPhoneInitial).status == UpdateEmailPhoneStatus.loading,
                        onPressed: () {
                          context.read<UpdateEmailPhoneCubit>().sendCodeToNewEmail(
                                _newEmailController.text,
                              );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: theme.spacing.inline.sm + MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
