import 'package:flutter/material.dart';

class ContinueNavigationButton extends StatelessWidget {
  const ContinueNavigationButton({
    super.key,
    required this.toAddress,
    required this.fromAddress,
  });
  final String toAddress;
  final String fromAddress;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      // TODO: mejorar esta implementacion con el estado.
      onPressed: toAddress.isNotEmpty & fromAddress.isNotEmpty
          ? () async {
              //TODO: usar informacion de los textFields para
              //actualizar la vista del mapa y el resto de funcionalidades

              Navigator.of(context).pop(); // Se cierra el modal
            }
          : null,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Continuar',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
