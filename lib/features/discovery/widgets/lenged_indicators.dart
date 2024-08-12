import 'package:flutter/material.dart';
import 'package:guardowl/utils/drop_marker.dart';

class LengedIndicators extends StatelessWidget {
  const LengedIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return Container(
      width: 200,
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Legend:", style: titleStyle),
          _TitleIcon(title: 'High', colorMarker: color.tertiary),
          const _TitleIcon(title: 'Medium', colorMarker: Colors.amber),
          _TitleIcon(title: 'Good', colorMarker: color.secondary),
        ],
      ),
    );
  }
}

class _TitleIcon extends StatelessWidget {
  final String title;
  final Color colorMarker;
  const _TitleIcon({
    required this.title,
    required this.colorMarker,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final titleStyle = textTheme.bodyLarge?.copyWith(color: colorMarker);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        DropMarker(
          colorMarker: colorMarker,
          icon: Text(
            '!',
            style: TextStyle(
              color: color.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
