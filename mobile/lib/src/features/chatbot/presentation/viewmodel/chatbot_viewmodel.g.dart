// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatbotViewModel on _ChatbotViewModel, Store {
  late final _$chatUserAtom =
      Atom(name: '_ChatbotViewModel.chatUser', context: context);

  @override
  ChatUser get chatUser {
    _$chatUserAtom.reportRead();
    return super.chatUser;
  }

  @override
  set chatUser(ChatUser value) {
    _$chatUserAtom.reportWrite(value, super.chatUser, () {
      super.chatUser = value;
    });
  }

  late final _$sessionIdAtom =
      Atom(name: '_ChatbotViewModel.sessionId', context: context);

  @override
  String get sessionId {
    _$sessionIdAtom.reportRead();
    return super.sessionId;
  }

  @override
  set sessionId(String value) {
    _$sessionIdAtom.reportWrite(value, super.sessionId, () {
      super.sessionId = value;
    });
  }

  late final _$botUserAtom =
      Atom(name: '_ChatbotViewModel.botUser', context: context);

  @override
  ChatUser get botUser {
    _$botUserAtom.reportRead();
    return super.botUser;
  }

  @override
  set botUser(ChatUser value) {
    _$botUserAtom.reportWrite(value, super.botUser, () {
      super.botUser = value;
    });
  }

  late final _$errorLoadAtom =
      Atom(name: '_ChatbotViewModel.errorLoad', context: context);

  @override
  String? get errorLoad {
    _$errorLoadAtom.reportRead();
    return super.errorLoad;
  }

  @override
  set errorLoad(String? value) {
    _$errorLoadAtom.reportWrite(value, super.errorLoad, () {
      super.errorLoad = value;
    });
  }

  late final _$messageListAtom =
      Atom(name: '_ChatbotViewModel.messageList', context: context);

  @override
  List<ChatMessage> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(List<ChatMessage> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  late final _$_ChatbotViewModelActionController =
      ActionController(name: '_ChatbotViewModel', context: context);

  @override
  dynamic updateChatUser(ChatUser value) {
    final _$actionInfo = _$_ChatbotViewModelActionController.startAction(
        name: '_ChatbotViewModel.updateChatUser');
    try {
      return super.updateChatUser(value);
    } finally {
      _$_ChatbotViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateErrorLoad(String? value) {
    final _$actionInfo = _$_ChatbotViewModelActionController.startAction(
        name: '_ChatbotViewModel.updateErrorLoad');
    try {
      return super.updateErrorLoad(value);
    } finally {
      _$_ChatbotViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateSessionId(String value) {
    final _$actionInfo = _$_ChatbotViewModelActionController.startAction(
        name: '_ChatbotViewModel.updateSessionId');
    try {
      return super.updateSessionId(value);
    } finally {
      _$_ChatbotViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic insertMessage(ChatMessage m) {
    final _$actionInfo = _$_ChatbotViewModelActionController.startAction(
        name: '_ChatbotViewModel.insertMessage');
    try {
      return super.insertMessage(m);
    } finally {
      _$_ChatbotViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatUser: ${chatUser},
sessionId: ${sessionId},
botUser: ${botUser},
errorLoad: ${errorLoad},
messageList: ${messageList}
    ''';
  }
}
