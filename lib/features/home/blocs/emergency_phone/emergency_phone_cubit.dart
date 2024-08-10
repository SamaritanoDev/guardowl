import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/constants/enviroments_assets.dart';
import 'package:guardowl/features/home/models/emergency_numbers.dart';
part 'emergency_phone_state.dart';

class EmergencyPhoneCubit extends Cubit<EmergencyPhoneState> {
  EmergencyPhoneCubit()
      : super(
          EmergencyPhoneState(
            numbers: const [],
            status: InitialLoadingState(),
          ),
        ) {
    _loadArticlesFromFile(jsonNumbersMap);
  }

  void _markAsLoaded(List<EmergencyNumbers> numbers) {
    emit(EmergencyPhoneState(
      numbers: numbers,
      status: LoadedState(numbers: numbers),
    ));
  }

  void _loadArticlesFromFile(String filePath) async {
    emit(
      EmergencyPhoneState(
        numbers: const [],
        status: InitialLoadingState(),
      ),
    );
    try {
      String jsonString = await rootBundle.loadString(filePath);
      List<EmergencyNumbers> emergencyNumbers =
          emergencyNumbersFromJson(jsonString);

      // Verificar el contenido del JSON
      for (var destination in emergencyNumbers) {
        print(
            'Loaded emergency number: ${destination.entityName} - ${destination.number}');
      }

      if (emergencyNumbers.isNotEmpty) {
        _markAsLoaded(emergencyNumbers);
      } else {
        emit(
          EmergencyPhoneState(
            numbers: const [],
            status: EmptyState(),
          ),
        );
      }
    } catch (e) {
      emit(
        EmergencyPhoneState(
          numbers: const [],
          status: ErrorState(error: e.toString()),
        ),
      );
    }
  }

  Future<void> addAllContacts() async {
    final numbers = state.numbers;

    for (var emergencyNumber in numbers) {
      final contact = Contact(
        displayName: emergencyNumber.entityName,
        phones: [Item(value: emergencyNumber.number)],
      );

      print(
          'Adding contact: ${contact.displayName} - ${contact.phones?.first.value}');

      try {
        await ContactsService.addContact(contact);
        print(
            'Contact added: ${contact.displayName} - ${contact.phones?.first.value}');
      } catch (e) {
        print('Failed to add contact ${emergencyNumber.number}: $e');
      }
    }
  }
}
