import 'package:flutter/material.dart';
import 'package:guardowl/constants/constants.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(placeholderGuardowl),
      ),
    );
  }
}
