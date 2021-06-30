import 'package:flutter/material.dart';

class AddressInput extends StatelessWidget {
  final Function(String)? onChanged;
  final String label;
  final TextEditingController controller;

  const AddressInput({
    Key? key,
    required this.controller,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          labelText: '$label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
