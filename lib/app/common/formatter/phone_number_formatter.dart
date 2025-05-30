import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final phoneNumberFormatter = MaskTextInputFormatter(
  mask: '(###) ###-####',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final phoneWithCountryCodeFormatter = MaskTextInputFormatter(
  mask: '+# (###) ###-####',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
