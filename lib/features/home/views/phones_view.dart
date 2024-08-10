import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/home/blocs/emergency_phone/emergency_phone_cubit.dart';
import 'package:guardowl/features/home/models/emergency_numbers.dart';
import 'package:guardowl/features/share/my_app_bar_arrow.dart';

class PhonesView extends StatelessWidget {
  const PhonesView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    const signInStyleButton =
        ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(300, 50)));

    final watchNumbers = context.watch<EmergencyPhoneCubit>().state;
    final readNumbersCubit = context.read<EmergencyPhoneCubit>();

    return Scaffold(
      backgroundColor: color.onPrimary,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBarArrow(title: 'My emergency numbers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<EmergencyPhoneCubit, EmergencyPhoneState>(
              builder: (context, state) {
                if (state.status is InitialLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status is EmptyState) {
                  return const Center(
                      child: Text('No emergency numbers available.'));
                } else if (state.status is LoadedState) {
                  final numbers = watchNumbers.numbers;

                  return ListView.builder(
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        final numberEmergency = numbers[index];
                        return PhoneNumberList(phoneNumbers: numberEmergency);
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          FilledButton(
            style: signInStyleButton,
            onPressed: () async {
              await readNumbersCubit.addAllContacts();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All contacts added')),
              );
            },
            child: const Text('All contacts added'),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class PhoneNumberList extends StatelessWidget {
  final EmergencyNumbers phoneNumbers;

  const PhoneNumberList({
    super.key,
    required this.phoneNumbers,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textTitleLargePrimary = textTheme.titleMedium?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );
    final textSubTitleBody = textTheme.bodyLarge?.copyWith(
      color: color.secondary,
    );

    return ListTile(
      title: Text(phoneNumbers.entityName, style: textTitleLargePrimary),
      subtitle: Text(phoneNumbers.number, style: textSubTitleBody),
      trailing: IconButton(
        icon: Icon(Icons.add, color: color.secondary, size: 30),
        onPressed: () {
          // Aquí podrías implementar la lógica de añadir el contacto individualmente
        },
      ),
    );
  }
}
