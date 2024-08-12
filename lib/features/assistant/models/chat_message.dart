// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

typedef GuardOwlMessage = UserMessage;
typedef UserMessage = ChatMessage;

class ChatMessage {
  ChatMessage({
    required this.userId,
    required this.createdAt,
    required this.message,
    required this.destination,
  });

  final String userId;
  final DateTime createdAt;
  final String message;
  final String destination;

  factory ChatMessage.fromFirebaseUser(Map<String, dynamic> data) {
    String getData(String key) => data[key] as String? ?? '';
    // mejorar esto luego
    DateTime getTimestamp(String key) {
      final timestamp = data[key] as Timestamp?;
      return timestamp?.toDate() ?? DateTime.now();
    }

    return ChatMessage(
      userId: getData('userId'),
      createdAt: getTimestamp('createdAt'),
      message: getData('message'),
      destination: getData('destination'),
    );
  }

  Map<String, dynamic> toMapFirestore() {
    return {
      'userId': userId,
      'createdAt': createdAt,
      'message': message,
      'destination': destination,
    };
  }

  UserMessage copyWith({
    String? userId,
    DateTime? createdAt,
    String? message,
    String? destination,
  }) {
    return ChatMessage(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      destination: destination ?? this.destination,
    );
  }

  @override
  String toString() {
    return 'UserMessage(userId: $userId, createdAt: $createdAt, message: $message, destination: $destination)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.createdAt == createdAt &&
        other.message == message &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ createdAt.hashCode ^ message.hashCode ^ destination.hashCode;
  }
}
