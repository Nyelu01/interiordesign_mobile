import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  LoginModel({
    required this.message,
    required this.user,
    required this.token,
  });

  final String? message;
  final User? user;
  final String? token;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
        "token": token,
      };

  @override
  List<Object?> get props => [
        message,
        user,
        token,
      ];
}

class User extends Equatable {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.serviceType,
    required this.projectType,
    required this.certificate,
    required this.businessLicence,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? location;
  final dynamic serviceType;
  final dynamic projectType;
  final dynamic certificate;
  final dynamic businessLicence;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      location: json["location"],
      serviceType: json["service_type"],
      projectType: json["project_type"],
      certificate: json["certificate"],
      businessLicence: json["business_licence"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
        "service_type": serviceType,
        "project_type": projectType,
        "certificate": certificate,
        "business_licence": businessLicence,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        location,
        serviceType,
        projectType,
        certificate,
        businessLicence,
        role,
        createdAt,
        updatedAt,
      ];
}
