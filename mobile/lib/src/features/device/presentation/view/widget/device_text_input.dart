import 'package:flutter/material.dart';

class DeviceTextInput extends StatelessWidget {
  final Widget? prefixIcon;
  final bool obscureText;
  final void Function(String) onChange;
  final String label;
  final TextInputType? keyboardType;
  final String errorText;
  final String? initialValue;

  const DeviceTextInput(
      {Key? key,
      this.initialValue,
      required this.errorText,
      this.prefixIcon,
      this.obscureText = false,
      required this.onChange,
      this.label = "",
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: _theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: _theme.textTheme.titleMedium
                ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
            obscureText: obscureText,
            decoration: InputDecoration(
              errorText: errorText.length > 1 ? errorText : null,
              hintText: label,
              hintStyle: _theme.textTheme.titleMedium
                  ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
              prefixIcon: prefixIcon,
            ),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
