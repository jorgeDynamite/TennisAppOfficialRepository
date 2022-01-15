import 'package:app/colors.dart';
import 'package:flutter/material.dart';

import '../../Players.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  final double? fontSize;
  final double? iconSize;

  const MenuItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.fontSize,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: iconSize == null ? 30 : iconSize,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: fontSize == null ? 26 : fontSize,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItemPlayers extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color color;
  final Color iconColor;
  final List<Player> players;
  final List<Widget> playersWidgets;
  final int index;

  const MenuItemPlayers(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.color,
      required this.iconColor,
      required this.players,
      required this.index,
      required this.playersWidgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 22, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
