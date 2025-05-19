import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/environment/domain/entities/env_type.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/network/channel/environment_channel.dart';

class EndpointXdebuggingPage extends StatefulWidget {
  const EndpointXdebuggingPage({
    required this.environmentChannel,
    super.key,
  });

  final EnvironmentChannel environmentChannel;

  @override
  State<EndpointXdebuggingPage> createState() => _EndpointXdebuggingPageState();
}

class _EndpointXdebuggingPageState extends State<EndpointXdebuggingPage> {
  EnvType? _selectedEnvType;

  @override
  void initState() {
    _selectedEnvType = widget.environmentChannel.getEnvType();
    super.initState();
  }

  void _changeEnvType(EnvType envType) {
    widget.environmentChannel.setEnvironment(envType);
    setState(() {
      _selectedEnvType = envType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Environment'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: EnvType.values.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  title: Text(EnvType.values[index].toString()),
                  value: EnvType.values[index],
                  groupValue: _selectedEnvType,
                  onChanged: (EnvType? value) {
                    _changeEnvType(value!);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
