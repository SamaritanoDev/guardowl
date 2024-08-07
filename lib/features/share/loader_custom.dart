import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(placeholderGuardowl),
      ),
    );
  }
}
