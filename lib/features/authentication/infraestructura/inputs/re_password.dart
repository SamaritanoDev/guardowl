import 'package:formz/formz.dart';

enum RePasswordError { empty, length }

class RePassword extends FormzInput<String, RePasswordError> {
  const RePassword.pure() : super.pure('');
  const RePassword.dirty([super.value = '']) : super.dirty();

  static final _rePasswordRegExp = RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$');

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RePasswordError.empty) return 'The field is required.';
    if (displayError == RePasswordError.length) return 'Minimum 8 characters.';

    return null;
  }

  @override
  RePasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return RePasswordError.empty;
    return _rePasswordRegExp.hasMatch(value) && value.length < 9
        ? null
        : RePasswordError.length;
  }
}

// class RePassword extends FormzInput<String, RePasswordError> {
//   const RePassword.pure() : super.pure('');

//   const RePassword.dirty(super.value) : super.dirty();

//   String? get errorMessage {
//     if (isValid || isPure) return null;

//     if (displayError == RePasswordError.empty) return 'The field is required.';
//     if (displayError == RePasswordError.length) return 'Minimum 8 characters.';

//     return null;
//   }

//   @override
//   RePasswordError? validator(String value) {
//     if (value.isEmpty || value.trim().isEmpty) return RePasswordError.empty;
//     if (value.length < 9) return RePasswordError.length;

//     return null;
//   }
// }
