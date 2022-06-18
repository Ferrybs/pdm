import 'package:basearch/src/features/home/data/dto/chatbot_message_dto.dart';
import 'package:basearch/src/features/home/presentation/view/widget/dialog_container_chat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ChatbotCard extends StatelessWidget {
  final int index;
  final ChatbotMessageDTO messageDTO;
  final void Function(String id) onTap;
  final Future<void> Function(String id) onDelete;
  final String id;
  const ChatbotCard(
      {Key? key,
      required this.id,
      required this.index,
      required this.messageDTO,
      required this.onTap,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: (() => onTap(id)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Dismissible(
            background: Container(
              color: _theme.colorScheme.onError,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(FontAwesomeIcons.trash),
                ),
              ),
            ),
            onDismissed: (onDimissed),
            confirmDismiss: onConfirmDimiss,
            key: ValueKey<int>(index),
            direction: DismissDirection.startToEnd,
            movementDuration: Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 0, right: 16, top: 10, bottom: 10),
              child: _chatCard(_theme),
            )),
      ),
    );
  }

  Row _chatCard(ThemeData _theme) {
    return Row(
      children: [
        Icon(
          Icons.more_vert,
          color: _theme.colorScheme.primary,
        ),
        CircleAvatar(
            backgroundImage:
                AssetImage("lib/assets/images/v968-10-ps_back.png"),
            maxRadius: 30),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plantie",
                style: _theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 16,
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: messageDTO.message,
                    style: _theme.textTheme.bodySmall),
              )
            ],
          ),
        ))
      ],
    );
  }

  onDimissed(direction) async => await onDelete(id);

  Future<bool?> onConfirmDimiss(direction) async {
    bool result = false;
    await SmartDialog.show(
        widget: DialogContainerChat(
      message: "confirm-delete-chat".i18n(),
      buttonTextConfirm: "yes".i18n(),
      buttonTextDecline: "not".i18n(),
      onClickDecline: () {
        result = false;
        SmartDialog.dismiss();
      },
      onClickConfirm: () {
        result = true;
        SmartDialog.dismiss();
      },
    ));
    return result;
  }
}
