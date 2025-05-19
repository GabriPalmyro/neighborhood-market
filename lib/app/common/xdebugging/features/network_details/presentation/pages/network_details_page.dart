import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/network_details/presentation/pages/response_details_page.dart';

import '../../../network/data/models/api_response.dart';
import 'overview_page.dart';

class NetworkDetailsPage extends StatelessWidget {
  NetworkDetailsPage({super.key, required this.apiResponse});

  final ApiResponse apiResponse;
  final _titles = ['OVERVIEW', 'REQUEST', 'RESPONSE'];

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Network Details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _copyToClipboard(context, apiResponse.body.toString()),
            ),
          ],
          bottom: TabBar(
            tabs: _titles.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            OverviewPage(apiResponse: apiResponse),
            Container(),
            ResponseDetailsPage(body: apiResponse.body),
          ],
        ),
      ),
    );
  }
}
