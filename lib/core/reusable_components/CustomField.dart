import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  String hint;
  String? prefix;
  int maxLines;
  bool isPassword;
  String? Function(String?) validation;
  TextEditingController controller;

  final Function(String)? onChanged;

  CustomField({
    required this.validation,
    this.maxLines = 1,
    required this.hint,
    this.prefix,
    this.isPassword = false,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isObscured = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validation,
      style: Theme.of(context).textTheme.titleMedium,
      obscureText: widget.isPassword ? isObscured : false,
      obscuringCharacter: "*",

      onChanged: widget.onChanged,

      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
          icon: Icon(
            isObscured ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        )
            : null,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 60,
          maxHeight: 60,
        ),
        prefixIcon: widget.prefix == null
            ? null
            : Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            widget.prefix!,
            height: 40,
            width: 40,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.tertiary,
              BlendMode.srcIn,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}
