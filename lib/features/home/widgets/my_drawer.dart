import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';
import 'package:guardowl/features/authentication/blocs/sign_in/sign_in_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final textLargeStyle = textTheme.titleMedium?.copyWith(
      color: color.onPrimary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: color.primary,
          ),
          child: Container(
            width: double.infinity,
            color: color.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: color.onPrimary)),
                const Spacer(),
                Text('nombre y apellido', style: textLargeStyle),
                Text('correo electronico', style: textLargeStyle),
              ],
            ),
          ),
        ),
        //options
        _MyListTileDrawer(
          label: 'Settings',
          icon: Icons.settings_outlined,
          onTap: () {},
        ),
        _MyListTileDrawer(
          label: 'Log out',
          icon: Icons.logout_outlined,
          onTap: () {
            //todo: colorcar para cerrar sesión
            context.read<AuthCubit>().signOut();
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _MyListTileDrawer extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  const _MyListTileDrawer({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final labelStyle = textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: color.primary,
    );

    final iconColor = color.primary;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label, style: labelStyle),
      onTap: onTap,
    );
  }
}
