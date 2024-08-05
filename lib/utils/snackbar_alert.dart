import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure(
    {required String snackBarFailureText, required Color color}) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: color,
  );
}

SnackBar snackBarWhenSuccess({required Color color}) {
  return SnackBar(
    content: const Text("Success!"),
    backgroundColor: color,
  );
}
