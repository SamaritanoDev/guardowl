import 'package:formz/formz.dart';

enum FirstNameError { empty, length }

class FirstName extends FormzInput<String, FirstNameError> {
  const FirstName.pure() : super.pure('');

  const FirstName.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == FirstNameError.empty) return 'The field is required.';
    
    return null;
  }

  @override
  FirstNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return FirstNameError.empty;
    if (value.length < 6) return FirstNameError.length;

    return null;
  }
}
