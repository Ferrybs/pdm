import 'package:basearch/src/features/home/data/dto/chatbot_message_dto.dart';
import 'package:flutter/material.dart';

class ChatbotCard extends StatelessWidget {
  final int index;
  final ChatbotMessageDTO messageDTO;
  final void Function(String id) onTap;
  final String id;
  const ChatbotCard(
      {Key? key,
      required this.id,
      required this.index,
      required this.messageDTO,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: (() => onTap(id)),
      child: Dismissible(
          key: ValueKey<int>(index),
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundImage:
                        AssetImage("lib/assets/images/v968-10-ps.png"),
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
            ),
          )),
    );
  }
}
