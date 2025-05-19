import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neighborhood_market/app/common/design_system/components/button/button_component.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/features/my_profile/presentation/cubit/update_profile_photo/update_profile_photo_cubit.dart';

class UpdateProfilePictureModal extends StatelessWidget {
  const UpdateProfilePictureModal({required this.onImageChanged, super.key});

  final Function(String) onImageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.inline.xs,
        ),
        child: BlocListener<UpdateProfilePhotoCubit, UpdateProfilePhotoState>(
          listener: (context, state) {
            if (state is UpdateProfilePhotoSuccess) {
              onImageChanged.call(state.newPath);
            }
          },
          child: Column(
            children: [
              // SizedBox(height: theme.spacing.inline.sm),
              // DSButton(
              //   label: 'Remove Profile Picture',
              //   type: DSButtonType.primaryOutline,
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              SizedBox(height: theme.spacing.inline.xs),
              DSButton(
                label: 'Upload Profile Picture',
                isLoading: context.watch<UpdateProfilePhotoCubit>().state is UpdateProfilePhotoLoading,
                onPressed: () {
                  context.read<UpdateProfilePhotoCubit>().updateProfilePhoto();
                },
              ),
              SizedBox(
                height: theme.spacing.inline.lg + MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
