// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../services/mock.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String uid;

  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.imageUrl,
      required this.uid});

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    String? uid,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'uid': uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  static User createMockUser() {
    return User(
      firstName: Mock.firstName(),
      lastName: Mock.lastName(),
      email: Mock.email(),
      imageUrl: Mock.imageUrl(),
      uid: Mock.uid(),
    );
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, imageUrl: $imageUrl, uid: $uid)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        uid.hashCode;
  }
}
