import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagePayload {
  final String? message;
  final dynamic payload;

  MessagePayload({this.message, this.payload});

  MessagePayload copyWith({String? message, dynamic payload}) {
    return MessagePayload(
      message: message ?? this.message,
      payload: payload ?? this.payload,
    );
  }
}

class MessageNotifier extends ChangeNotifier {
  MessagePayload? _state;
  MessagePayload? get state => _state;

  final String targetId;

  MessageNotifier(this.targetId);

  void sendMessage(String message, {dynamic payload}) {
    _state = MessagePayload(message: message, payload: payload);
    notifyListeners();
  }

  void clearMessage() {
    if (_state != null) {
      _state = null;
    }
  }
}

final messageProvider = ChangeNotifierProvider.family<MessageNotifier, String>(
  (ref, targetId) => MessageNotifier(targetId),
);
