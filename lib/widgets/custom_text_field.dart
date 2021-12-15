import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    this.suffix,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.validator,
    this.onSubmitted,
  }) : super(key: key);

  final String label;
  final String? suffix;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction:
          nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
      style: const TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      validator: validator,
      onFieldSubmitted: (value) {
        onSubmitted?.call(value);
        if (nextFocusNode == null) return;
        nextFocusNode?.requestFocus();
      },
    );
  }
}
