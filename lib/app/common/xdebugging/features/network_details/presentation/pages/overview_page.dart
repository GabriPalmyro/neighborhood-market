import 'package:flutter/material.dart';

import '../../../network/data/models/api_response.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({required this.apiResponse, super.key});

  final ApiResponse apiResponse;

  @override
  Widget build(BuildContext context) {
    final items = {
      'URL': '${apiResponse.baseUrl}',
      'Method': apiResponse.method,
      'Response Code': apiResponse.statusCode.toString(),
      'Response Type': apiResponse.responseType,
      'Request Time': apiResponse.requestTime!.toIso8601String(),
      'Query Params': apiResponse.queryParameters,
      'Body': apiResponse.request.toString(),
      'Response': apiResponse.body,
      'Header': apiResponse.headers,
      'CURL': apiResponse.curl,
    };

    return ListView.separated(
      itemCount: items.length,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final key = items.keys.elementAt(index);
        final value = items.values.elementAt(index);

        return Column(
          children: [
            ListTile(
              title: Text(key),
              subtitle: Text(value.toString()),
            ),
            const Divider(
              color: Colors.black26,
            ),
          ],
        );
      },
    );
  }
}
