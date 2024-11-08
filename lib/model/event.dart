// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final DateTime date;
  final String title;

  Event({
    required this.date,
    required this.title,
  });

  Event copyWith({
    DateTime? date,
    String? title,
  }) {
    return Event(
      date: date ?? this.date,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'title': title,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return <String, dynamic>{
      'date': Timestamp.fromDate(date),
      'title': title,
    };
  }

  factory Event.fromFirestoreMap(Map<String, dynamic> firestoreMap) {
    return Event(
        date: (firestoreMap['date'] as Timestamp).toDate(),
        title: firestoreMap['title']);
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Event(date: $date, title: $title)';

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.date == date && other.title == title;
  }

  @override
  int get hashCode => date.hashCode ^ title.hashCode;
}
