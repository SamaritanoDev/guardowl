import 'package:flutter/material.dart';

class MyAppBarArrow extends StatelessWidget {
  final String? title;
  const MyAppBarArrow({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textTitlePrimary = textTheme.titleLarge?.copyWith(
      color: color.primary,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '', style: textTitlePrimary),
        backgroundColor: color.onPrimary,
        leadingWidth: 80,
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 30,
              color: color.primary,
            ),
          ),
        ),
      ),
    );
  }
}
