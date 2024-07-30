import 'package:flutter/material.dart';
import 'package:guardowl/config/config.dart';
import 'package:guardowl/constants/enviroments_assets.dart';
import 'package:guardowl/constants/enviroments_search_view.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: paddingAppBar,
        right: paddingAppBar,
        bottom: 17,
      ),
      height: sizeHeightAppBar,
      color: colorScheme.primary,
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
    return GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.notifications_none_outlined,
        size: sizeIconsAppBar,
        color: colorScheme.onPrimary,
      ),
    );
  }
}

class _TitleAppBar extends StatelessWidget {
  const _TitleAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          logoOwlPng,
          width: 28.65,
          height: 33,
        ),
        const SizedBox(width: 12.58),
        Image.asset(
          logoGuardOwlPng,
          height: sizeIconsAppBar,
        )
      ],
    );
  }
}
