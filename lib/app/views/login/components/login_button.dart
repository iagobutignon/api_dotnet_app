import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const LoginButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      child: Text('$title'),
    );
  }
}
