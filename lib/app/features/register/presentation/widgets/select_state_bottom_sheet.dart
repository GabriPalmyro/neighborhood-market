import 'package:flutter/material.dart';
import 'package:neighborhood_market/app/common/design_system/components/text/text_widget.dart';
import 'package:neighborhood_market/app/common/design_system/components/text_field/text_field_widget.dart';
import 'package:neighborhood_market/app/common/design_system/core/theme/ds_theme.dart';
import 'package:neighborhood_market/app/common/states/models/states.dart';
import 'package:neighborhood_market/app/common/states/utils/states_utils.dart';

class SelectStateBottomSheet extends StatefulWidget {
  const SelectStateBottomSheet({required this.onSelected, super.key});

  final Function(String) onSelected;

  @override
  State<SelectStateBottomSheet> createState() => _SelectStateBottomSheetState();
}

class _SelectStateBottomSheetState extends State<SelectStateBottomSheet> {
  List<CountryState> usaStates = [];

  @override
  void initState() {
    _getStates('US');
    super.initState();
  }

  Future<void> _getStates(String countryCode) async {
    final states = await getStatesOfCountry(countryCode);
    setState(() {
      usaStates = states;
    });
  }

  void _search(String query) {
    if (query.isEmpty) {
      _getStates('US');
      return;
    }

    final states = usaStates.where((state) {
      return state.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      usaStates = states;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.getDesignTokensOf(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.inline.xs,
            ).copyWith(
              top: theme.spacing.inline.xs,
            ),
            child: DSTextField(
              label: 'Search',
              hintText: 'Search',
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: usaStates.length,
              itemBuilder: (context, index) {
                final state = usaStates[index];
                return ListTile(
                  title: DSText(state.name),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onSelected(state.name);
                  },
                );
              },
            ),
          ),
          SizedBox(height: theme.spacing.inline.md),
        ],
      ),
    );
  }
}
