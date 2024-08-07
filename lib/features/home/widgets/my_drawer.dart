import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardowl/features/authentication/blocs/auth/auth_cubit.dart';

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
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
                const Spacer(),
                const _ThemeDarkLight(),
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
          label: 'My favourites',
          icon: Icons.favorite_border,
          onTap: () {},
        ),
        _MyListTileDrawer(
          label: 'Log out',
          icon: Icons.logout_outlined,
          onTap: () async {
            await context.read<AuthCubit>().signOut();
            //todo: arreglar el contexto
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (Route<dynamic> route) => false,
            );
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

class _ThemeDarkLight extends StatefulWidget {
  const _ThemeDarkLight({super.key});

  @override
  State<_ThemeDarkLight> createState() => __ThemeDarkLightState();
}

class __ThemeDarkLightState extends State<_ThemeDarkLight> {
  bool light = true;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(
          Icons.light_mode_outlined,
        );
      }
      return const Icon(Icons.mode_night_outlined);
    },
  );

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Switch(
      activeColor: color.secondary,
      activeTrackColor: color.onPrimary,
      inactiveThumbColor: color.tertiary,
      inactiveTrackColor: color.shadow,
      thumbIcon: thumbIcon,
      value: light,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
