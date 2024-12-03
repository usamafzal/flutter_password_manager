// Importing Flutter's material design package
import 'package:flutter/material.dart';

// Custom TextFormField widget to standardize text input fields across the app
class CustomTextFormField extends StatelessWidget {
  // Initial value of the text field, useful for editing
  final String? initialValue;

  // Label text displayed above the text field
  final String labelText;

  // Hint text displayed within the text field when empty
  final String hintText;

  // Whether the text field hides its content (useful for passwords)
  final bool secure;

  // Validator function to check the validity of the input
  final String? Function(String?)? validator;

  // Callback function to handle changes in the text field
  final void Function(String)? onChanged;

  // Constructor for initializing the text field properties
  const CustomTextFormField({
    super.key,
    this.initialValue, // Default is null for new fields
    required this.labelText,
    required this.hintText,
    this.validator, // Default is null if no validation is needed
    this.onChanged, // Default is null if no change handling is required
    this.secure = false, // Default is false for non-password fields
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Set the initial value for the text field
      initialValue: initialValue,

      // Whether the text field should obscure its text
      obscureText: secure,

      // Input decoration for styling the text field
      decoration: InputDecoration(
        // Outline border style with rounded corners
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        // Label displayed above the text field
        labelText: labelText,
        // Hint text displayed inside the text field
        hintText: hintText,
      ),

      // Validator function to validate the input
      validator: validator,

      // Callback for handling text changes
      onChanged: onChanged,
    );
  }
}
