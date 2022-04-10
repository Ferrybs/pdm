import 'package:flutter/material.dart';

class TextInputAuth extends StatelessWidget {
  const TextInputAuth(
      {Key? key,
      this.prefixIcon,
      this.obscureText = false,
      this.onChange,
      required this.label,
      this.keyboardType})
      : super(key: key);
  final Widget? prefixIcon;
  final bool obscureText;
  final void Function(String)? onChange;
  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: _theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: keyboardType,
            style: _theme.textTheme.titleMedium
                ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
            ),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
