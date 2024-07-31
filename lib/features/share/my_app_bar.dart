import 'package:flutter/material.dart';
import 'package:guardowl/constants/enviroments_assets.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(
        left: paddingAppBar,
        right: paddingAppBar,
        bottom: 17,
      ),
      height: sizeHeightAppBar,
      color: color.primary,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //icon menu
          _Menubutton(),
          Spacer(),
          //title app bar
          _TitleAppBar(),
          Spacer(),
          // icon notification
          _NotificationButton(),
        ],
      ),
    );
  }
}

class _Menubutton extends StatelessWidget {
  const _Menubutton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(
        menuIconPng,
        width: sizeIconsAppBar,
        height: sizeIconsAppBar,
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.notifications_none_outlined,
        size: sizeIconsAppBar,
        color: color.onPrimary,
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
