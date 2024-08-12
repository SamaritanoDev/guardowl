import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure({required String snackBarFailureText, required Color color}) {
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

SnackBar snackBarNewFavouriteItem({required Color color}) {
  return SnackBar(
    content: const Text("Item added to your wish list!"),
    backgroundColor: color,
  );
}
