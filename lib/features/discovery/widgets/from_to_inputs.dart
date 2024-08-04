import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/widgets/custom_textformfield.dart';

enum _AddressInputs { from, to }

extension _OnAddressInputs on _AddressInputs {
  ({String label, TextInputAction action}) get resources => switch (this) {
        _AddressInputs.from => (
            label: 'Mi ubicacion',
            action: TextInputAction.next,
          ),
        _AddressInputs.to => (
            label: 'Destination',
            action: TextInputAction.done,
          ),
      };

  Function(String) getOnchanged(Function(String) from, Function(String) to) => switch (this) {
        _AddressInputs.from => from,
        _AddressInputs.to => to,
      };
}

class FromToInputs extends StatelessWidget {
  const FromToInputs({
    super.key,
    required this.isLoading,
    required this.onChangedTo,
    required this.onChangedFrom,
  });

  final bool isLoading;
  final Function(String) onChangedTo;
  final Function(String) onChangedFrom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._AddressInputs.values.map(
          (value) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomTextFormField(
              action: value.resources.action,
              label: value.resources.label,
              onChanged: value.getOnchanged(
                onChangedFrom,
                onChangedTo,
              ),
              isLoading: isLoading,
            ),
          ),
        ),
      ],
    );
  }
}
