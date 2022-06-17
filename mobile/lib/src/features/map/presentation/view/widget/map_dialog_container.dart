import 'package:flutter/material.dart';

class MapDialogContainer extends StatelessWidget {
  final String message;
  final String buttonText;
  final void Function() onClick;
  const MapDialogContainer({
    Key? key,
    required this.message,
    required this.buttonText,
    required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Flexible(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.zero,
            )),
        Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 8,
                  child: Container(
                      decoration: BoxDecoration(
                        color: _theme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              message,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          TextButton(
                            child: Text(buttonText),
                            onPressed: onClick,
                          )
                        ],
                      ))),
                ),
                const Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.zero,
                    ))
              ],
            )),
        const Flexible(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.zero,
            )),
      ],
    );
  }
}
