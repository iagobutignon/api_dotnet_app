import 'package:flutter/material.dart';

class CustomerInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final Function? onTap;

  const CustomerInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        readOnly: onTap != null ? true : false,
        onTap: onTap != null ? () => onTap!() : null,
        controller: controller,
        decoration: InputDecoration(
          labelText: '$label',
          prefixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(25)),
          ),
        ),
      ),
    );
  }
}
