import 'package:flutter/material.dart';

// quiza se deba crear un widget independiente para los mensajes del usuario
// y otro para los de guardowl se pasaria el modelo respectivo a cada widget
// para ser utilizado segun lo necesite [User or GuardOwl]
// ya que Los mensajes de GuardOwl pueden contener [Actividades] o [itinerario]
// para mostrarse en la UI.

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({super.key, required this.isUserMessage, required this.message});

  final bool isUserMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final textStyleYou = textTheme.labelSmall?.copyWith(
      color: color.shadow,
    );

    final textStyleAssistant = textTheme.labelSmall?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    final textBodyYou = textTheme.bodyMedium?.copyWith(
      color: color.shadow,
    );

    final textBodyAssistant = textTheme.bodySmall?.copyWith(
      color: color.primary,
      fontWeight: FontWeight.bold,
    );

    return ListTile(
      title: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: isUserMessage ? Text('You', style: textStyleYou) : Text('Guardowl AI', style: textStyleAssistant),
      ),
      subtitle: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isUserMessage ? color.secondary : color.primaryContainer,
          ),
          child: Text(
            message,
            style: isUserMessage ? textBodyYou : textBodyAssistant,
          ),
        ),
      ),
    );
  }
}
