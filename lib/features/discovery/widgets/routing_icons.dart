import 'package:flutter/material.dart';

class RoutingIcons extends StatelessWidget {
  const RoutingIcons({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.radio_button_checked,
          color: primaryColor,
        ),
        const SizedBox(height: 8),
        ...List.generate(
          3,
          (_) => Container(
            height: 4.5,
            width: 2,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 8),
          ),
        ),
        Icon(
          Icons.my_location_sharp,
          color: primaryColor,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
