import 'package:flutter/material.dart';
import 'package:guardowl/utils/drop_marker.dart';

class LegendIndicators extends StatelessWidget {
  const LegendIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleSmall?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return Container(
      width: 116,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Risk Level", style: titleStyle),
          const SizedBox(height: 8),
          _TitleIcon(title: 'Height', colorMarker: color.error),
          const _TitleIcon(title: 'Medium', colorMarker: Color(0xfff7987b)),
          _TitleIcon(title: 'Low', colorMarker: color.secondary),
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
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final titleStyle = textTheme.bodyMedium?.copyWith(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 25,
            height: 20,
            child: DropMarker(
              colorMarker: colorMarker,
              icon: Text(
                '!',
                style: TextStyle(
                  color: color.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: titleStyle),
        ],
      ),
    );
  }
}
