import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cardNumberFormatter = MaskTextInputFormatter(
  mask: '#### #### #### ####',
  filter: {'#': RegExp(r'[0-9]')},
);

final expDateFormatter = MaskTextInputFormatter(
  mask: '##/##',
  filter: {'#': RegExp(r'[0-9]')},
);

final csvFormatter = MaskTextInputFormatter(
  mask: '###',
  filter: {'#': RegExp(r'[0-9]')},
);