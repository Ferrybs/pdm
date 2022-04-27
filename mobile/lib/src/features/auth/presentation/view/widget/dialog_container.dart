import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  final String message;
  final String buttonText;
  final double? height;
  final double? width;
  final void Function() onClick;

  const DialogContainer({
    Key? key,
    required this.message,
    required this.buttonText,
    required this.onClick,
    this.height,
    this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Container(
        height: height ?? 150,
        width: width ?? 230,
        decoration: BoxDecoration(
          color: _theme.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: _theme.textTheme.titleMedium,
              ),
            ),
            TextButton(
              child: Text(buttonText),
              onPressed: onClick,
            )
          ],
        ));
  }
}
