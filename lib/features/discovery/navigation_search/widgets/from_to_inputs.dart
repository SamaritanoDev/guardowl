import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/discovery/navigation_search/bloc/navigation_search_bloc.dart';
import 'package:guardowl/features/discovery/widgets/custom_textformfield.dart';

enum _AddressInputs { from, to }

extension _OnAddressInputs on _AddressInputs {
  ({String label, TextInputAction action}) get resources => switch (this) {
        _AddressInputs.from => (
            label: 'My ubication',
            action: TextInputAction.next,
          ),
        _AddressInputs.to => (
            label: 'Destination',
            action: TextInputAction.done,
          ),
      };
}

class FromToInputs extends StatelessWidget {
  const FromToInputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._AddressInputs.values.map(
          (value) => BlocSelector<NavigationSearchBloc, NavigationSearchState,
              LocationSearchState>(
            selector: (state) {
              return switch (value) {
                _AddressInputs.from => state.originState,
                _AddressInputs.to => state.destinationState,
              };
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: switch (state) {
                  LocationSearchInitial() => CustomTextFormField(
                      action: value.resources.action,
                      initialValue: null,
                      onTap: () {
                        final bloc =
                            BlocProvider.of<NavigationSearchBloc>(context);
                        Navigator.of(context).pop();
                        return switch (value) {
                          _AddressInputs.from =>
                            bloc.add(const SelectOriginCoordinates()),
                          _AddressInputs.to =>
                            bloc.add(const SelectDestinationCoordinates()),
                        };
                      },
                      label: value.resources.label,
                      isLoading: false,
                    ),
                  LocationSearchLoading() => CustomTextFormField(
                      action: value.resources.action,
                      initialValue: null,
                      onTap: () {},
                      label: 'Loading...',
                      isLoading: true,
                    ),
                  LocationSearchSelecting() => CustomTextFormField(
                      action: value.resources.action,
                      initialValue: null,
                      onTap: () {},
                      label: value.resources.label,
                      isLoading: true,
                    ),
                  LocationSearchSuccess(:String address) => CustomTextFormField(
                      action: value.resources.action,
                      key: Key(address),
                      initialValue: address,
                      onTap: () {
                        final bloc =
                            BlocProvider.of<NavigationSearchBloc>(context);
                        Navigator.of(context).pop();
                        return switch (value) {
                          _AddressInputs.from =>
                            bloc.add(const SelectOriginCoordinates()),
                          _AddressInputs.to =>
                            bloc.add(const SelectDestinationCoordinates()),
                        };
                      },
                      label: value.resources.label,
                      isLoading: false,
                    ),
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
