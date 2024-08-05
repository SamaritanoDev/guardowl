import 'package:formz/formz.dart';

enum LastNameError { empty, length }

class LastName extends FormzInput<String, LastNameError> {
  const LastName.pure() : super.pure('');

  const LastName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == LastNameError.empty) return 'The field is required.';

    return null;
  }

  @override
  LastNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return LastNameError.empty;
    if (value.length < 6) return LastNameError.length;

    return null;
  }
}
