import 'package:flutter/material.dart';

class DialogContainerChat extends StatelessWidget {
  final String message;
  final String buttonTextConfirm;
  final String buttonTextDecline;
  final void Function() onClickConfirm;
  final void Function() onClickDecline;
  const DialogContainerChat(
      {Key? key,
      required this.message,
      required this.buttonTextConfirm,
      required this.buttonTextDecline,
      required this.onClickConfirm,
      required this.onClickDecline})
      : super(key: key);
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
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              message,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(buttonTextConfirm),
                                onPressed: onClickConfirm,
                              ),
                              TextButton(
                                child: Text(buttonTextDecline),
                                onPressed: onClickDecline,
                              )
                            ],
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
