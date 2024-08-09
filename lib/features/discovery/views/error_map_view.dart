import 'package:flutter/material.dart';

import '../../../services/core/failures.dart';

class ErrorMapView extends StatelessWidget {
  final Failure failure;
  const ErrorMapView({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: ${failure.message}'));
  }
}
