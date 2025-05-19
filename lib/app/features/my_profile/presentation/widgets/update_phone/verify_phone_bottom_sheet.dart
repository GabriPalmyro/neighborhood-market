import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_variant.dart';
import 'package:neighborhood_market/app/common/design_system/components/recipies/text_input_label/text_input_label.dart';
import 'package:neighborhood_market/app/common/design_system/components/snackbar/snackbar_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_email_phone/update_email_phone_cubit.dart';

class VerifyPhoneBottomSheet extends StatefulWidget {
  const VerifyPhoneBottomSheet({super.key});

  @override
  State<VerifyPhoneBottomSheet> createState() => _VerifyPhoneBottomSheetState();
}

class _VerifyPhoneBottomSheetState extends State<VerifyPhoneBottomSheet> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
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
              'Verify Your Phone Number',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.bold,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxxs),
            DSText(
              'We just sent a 6-digit code to your new phone number. Enter it below to verify your update.',
              customStyle: TextStyle(
                fontSize: theme.font.size.xxs,
                fontWeight: theme.font.weight.regular,
              ),
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            TextInputLabelWidget(
              label: 'Code',
              hintText: 'Enter',
              controller: _codeController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(height: theme.spacing.inline.xxs),
            DSText(
              'Make sure your new phone number is valid and accessible. This will be used for account communications and recovery.',
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
                    if ((state as UpdateEmailPhoneInitial).status == UpdateEmailPhoneStatus.codeVerified) {
                      GetIt.I.get<AppNavigator>().pop();
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: DSButton(
                        label: _codeController.text.isEmpty ? 'Resend Code' : 'Update Number',
                        isLoading: (state as UpdateEmailPhoneInitial).status == UpdateEmailPhoneStatus.loading,
                        onPressed: () {
                          GetIt.I.get<AppNavigator>().pop();
                          ScaffoldMessenger.of(context).showSuccessSnackBar(
                            context,
                            content: 'Phone number updated successfully',
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
