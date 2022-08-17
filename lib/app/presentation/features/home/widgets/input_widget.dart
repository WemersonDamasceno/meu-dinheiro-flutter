import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextInputType type;
  final String labelText;
  final IconData? icon;
  final TextEditingController? txtController;

  const InputWidget({
    Key? key,
    this.type = TextInputType.text,
    required this.labelText,
    required this.icon,
    required this.txtController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 400,
      child: TextField(
        controller: txtController,
        keyboardType: type,
        cursorColor: const Color(0xFFBA2D0B),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(7),
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          prefixIcon: Icon(icon, color: const Color(0xFFBA2D0B)),
        ),
      ),
    );
  }
}
