import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/extensions/date_extension.dart';
import 'package:neighborhood_market/app/common/extensions/string_extension.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/data/models/exception_catch.dart';

class ExceptionTile extends StatelessWidget {
  const ExceptionTile({
    required this.exception,
    super.key,
  });

  final ExceptionCatch exception;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exception.errorType.toString().capitalize(),
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          exception.timestamp!.toTime(),
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(exception.errorMessage ?? ''),
        const SizedBox(height: 8),
        Text(
          exception.stackTrace?.toString() ?? '',
          style: textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
