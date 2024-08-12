import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_assets.dart';
import 'package:guardowl/features/share/loader_custom.dart';

class LoadingAssistant extends StatelessWidget {
  const LoadingAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textMessage = textTheme.bodyLarge?.copyWith(
      color: color.primary,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Stack(
              children: [
                RichText(
                  text: TextSpan(
                    style: textMessage,
                    children: [
                      const TextSpan(
                        text: "I'm generating custom content with ",
                      ),
                      TextSpan(
                        text: "Gemini AI.",
                        style:
                            textMessage?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: "        Please wait.",
                      ),
                    ],
                  ),
                  softWrap: true,
                ),
                Positioned(
                    top: 6,
                    right: 130,
                    child: Image.asset(
                      logoGemiini,
                      width: 50,
                      height: 50,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const BottomLoader(),
        ],
      ),
    );
  }
}
