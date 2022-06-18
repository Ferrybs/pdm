import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MapInfoDialog extends StatelessWidget {
  final String tittle;
  final String temperature;
  final String humidity;
  final String luminosity;
  final String moisture;
  final String onCancelText;
  final void Function() onCancel;
  const MapInfoDialog({
    Key? key,
    required this.tittle,
    required this.temperature,
    required this.humidity,
    required this.luminosity,
    required this.moisture,
    required this.onCancelText,
    required this.onCancel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Flexible(
            flex: 2,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Text(
                              tittle,
                              style: _theme.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
                            child: Text(
                              "temperature".i18n() + ": " + temperature,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(
                              "humidity".i18n() + ": " + humidity,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(
                              "luminosity".i18n() + ": " + luminosity,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(
                              "moisture".i18n() + ": " + moisture,
                              style: _theme.textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: Text(onCancelText),
                              onPressed: onCancel,
                            ),
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
            flex: 1,
            child: Padding(
              padding: EdgeInsets.zero,
            )),
      ],
    );
  }
}
