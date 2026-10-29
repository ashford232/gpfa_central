// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gpfa_central/app/auth/data/models/enums.dart';

class Admin {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final Role role;
  final DateTime createdAt;
  final DateTime updatedAt;
  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Admin copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    Role? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Admin(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'role': role.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      avatar: map['avatar'] as String,
      role: getRole(map['role'] as String),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) =>
      Admin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Admin(id: $id, name: $name, email: $email, phone: $phone, avatar: $avatar, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Admin other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.avatar == avatar &&
        other.role == role &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        avatar.hashCode ^
        role.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

final List<Admin> dummyAdmins = [
  Admin(
    id: 'admin_001',
    name: 'John Doe',
    email: 'john.doe@gpfa.org',
    phone: '+231770123456',
    avatar: 'https://i.pravatar.cc/150?img=12',
    role: Role.admin,
    createdAt: DateTime(2026, 1, 10),
    updatedAt: DateTime(2026, 1, 10),
  ),
  Admin(
    id: 'admin_002',
    name: 'Sarah Johnson',
    email: 'sarah.johnson@gpfa.org',
    phone: '+231880234567',
    avatar: 'https://i.pravatar.cc/150?img=47',
    role: Role.admin,
    createdAt: DateTime(2026, 2, 15),
    updatedAt: DateTime(2026, 3, 1),
  ),
  Admin(
    id: 'admin_003',
    name: 'Michael Cooper',
    email: 'michael.cooper@gpfa.org',
    phone: '+231770345678',
    avatar: 'https://i.pravatar.cc/150?img=33',
    role: Role.admin,
    createdAt: DateTime(2026, 4, 5),
    updatedAt: DateTime(2026, 4, 5),
  ),
  Admin(
    id: 'admin_004',
    name: 'Grace Williams',
    email: 'grace.williams@gpfa.org',
    phone: '+231880456789',
    avatar: 'https://i.pravatar.cc/150?img=44',
    role: Role.admin,
    createdAt: DateTime(2026, 5, 20),
    updatedAt: DateTime(2026, 6, 2),
  ),
];
