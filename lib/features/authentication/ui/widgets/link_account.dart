import 'package:flutter/material.dart';

class LinkAccount extends StatelessWidget {
  final String questionText;
  final String routeName;
  final VoidCallback onpressed;
  const LinkAccount({
    super.key,
    required this.routeName,
    required this.questionText,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    //styles
    final textLinkStyle = textTheme.titleMedium?.copyWith(         
      color: color.onSurfaceVariant,
    );
    final boldTextLinkStyle = textTheme.titleMedium?.copyWith(
      color: color.primary,
    );

    return InkWell(
      splashColor: Colors.transparent,
      onTap: onpressed,
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: questionText,
              style: textLinkStyle,
              children: <InlineSpan>[
                TextSpan(
                  text: ' Sign $routeName',
                  style: boldTextLinkStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
