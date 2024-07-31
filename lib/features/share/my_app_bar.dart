import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_assets.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';
import 'package:guardowl/features/share/custom_button_icon.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleAppBarStyle =
        textTheme.titleLarge?.copyWith(color: color.onPrimary);

    return Container(
      padding: const EdgeInsets.only(
        left: paddingAppBar,
        right: paddingAppBar,
        bottom: 17,
      ),
      height: sizeHeightAppBar,
      color: color.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //icon menu
          const CustomButtonIcon(
            icon: Icons.menu,
          ),
          const Spacer(),
          //title app bar
          Text('GuardOwl', style: titleAppBarStyle),
          const Spacer(),
          // icon notification
          const CustomButtonIcon(
            icon: Icons.notifications_none_outlined,
          ),
        ],
      ),
    );
  }
}

class _TitleAppBar extends StatelessWidget {
  const _TitleAppBar();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoGuardOwlPng,
      height: sizeIconsAppBar,
    );
  }
}
