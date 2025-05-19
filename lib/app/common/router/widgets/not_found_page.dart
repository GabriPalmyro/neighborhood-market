import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DSText('Not Found'),
      ),
      body: const Center(
        child: DSText(
          'Page Not Found',
          customStyle: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
