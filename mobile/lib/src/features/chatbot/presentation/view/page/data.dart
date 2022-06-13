import 'package:dash_chat_2/dash_chat_2.dart';

ChatUser user = ChatUser(id: '0');
ChatUser user3 = ChatUser(id: '3', lastName: 'Clark');

List<ChatMessage> quickReplies = <ChatMessage>[
  ChatMessage(
    text: 'How you doin?',
    user: user3,
    createdAt: DateTime.now(),
    quickReplies: <QuickReply>[
      QuickReply(title: 'Great!'),
      QuickReply(title: 'Awesome'),
    ],
  ),
];

List<ChatMessage> d = <ChatMessage>[];
