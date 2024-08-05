import 'package:formz/formz.dart';

enum PasswordError { empty, length, character }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');
  const Password.dirty(super.value) : super.dirty();

  static final _rePasswordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return 'The field is required.';
    if (displayError == PasswordError.length) return 'Minimum 8 characters.';
    if (displayError == PasswordError.character) {
      return 'Includes a special character.';
    }

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 8) return PasswordError.length;
    if (!_rePasswordRegExp.hasMatch(value)) return PasswordError.character;

    return null;
  }
}
