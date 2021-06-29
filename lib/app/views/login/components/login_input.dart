import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final String title;
  final Function onSaved;

  const LoginInput({
    Key? key,
    required this.title,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onSaved: (v) => onSaved(v),
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: '$title',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
