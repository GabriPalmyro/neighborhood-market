import 'dart:convert';

import 'package:flutter/widgets.dart';

class ResponseDetailsPage extends StatelessWidget {
  const ResponseDetailsPage({
    required this.body,
    super.key,
  });

  final dynamic body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SingleChildScrollView(
        child: Text(
          const JsonEncoder.withIndent('  ').convert(body),
          style: const TextStyle(fontFamily: 'Inter'),
        ),
      ),
    );
  }
}
