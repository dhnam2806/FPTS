import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon({required this.iconName, required void Function() onPressed,});

  final IconData iconName;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:  onPressed
     , icon: Icon(iconName));
  }
}
