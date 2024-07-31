import 'package:flutter/material.dart';
import 'package:guardowl/features/authentication/register_view.dart';
import 'package:guardowl/features/authentication/sing_in_view.dart';

class LinkAccount extends StatelessWidget {
  final String questionText;
  final String routeName;
  const LinkAccount({
    super.key,
    required this.routeName,
    required this.questionText,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    //styles
    final textLinkStyle = textTheme.titleMedium?.copyWith(
      color: const Color(0xff3F3F3F),
    );
    final boldTextLinkStyle = textTheme.titleMedium?.copyWith(
      color: color.primary,
    );

    return InkWell(
      // onTap: () => Navigator.pushNamed(context, '/sign$routeName'),
      onTap: () => {
        Navigator.push(
          context,
          routeName == 'up'
              ? MaterialPageRoute(
                  builder: (context) => const RegisterView(),
                )
              : MaterialPageRoute(
                  builder: (context) => const SingInView(),
                ),
        )
      },
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
