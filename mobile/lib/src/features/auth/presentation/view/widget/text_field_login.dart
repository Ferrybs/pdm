import 'package:flutter/material.dart';

class TextInputAuth extends StatefulWidget {
  TextInputAuth(
      {Key? key,
      this.errorText,
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
  String? errorText;

  @override
  State<TextInputAuth> createState() => _TextInputAuthState();
}

class _TextInputAuthState extends State<TextInputAuth> {
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
            widget.label,
            style: _theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: widget.keyboardType,
            style: _theme.textTheme.titleMedium
                ?.copyWith(color: _theme.textSelectionTheme.cursorColor),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon,
            ),
            onChanged: widget.onChange,
          ),
        ],
      ),
    );
  }
}
