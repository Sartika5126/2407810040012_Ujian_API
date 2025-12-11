import 'dart:convert';

class TodolistModel {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  TodolistModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
  });

  TodolistModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    int? age,
    String? email,
  }) {
    return TodolistModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email,
    };
  }

  factory TodolistModel.fromMap(Map<String, dynamic> map) {
    return TodolistModel(
      id: map['id']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age']?.toInt() ?? 0,
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodolistModel.fromJson(String source) => TodolistModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodolistModel(id: $id, firstName: $firstName, lastName: $lastName, age: $age, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TodolistModel &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.age == age &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      age.hashCode ^
      email.hashCode;
  }
}
