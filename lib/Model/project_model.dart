class ProjectModel {
  ProjectModel({
    required this.projects,
  });

  final List<ProjectItem> projects;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projects: json["projects"] == null
          ? []
          : List<ProjectItem>.from(
              json["projects"]!.map((x) => ProjectItem.fromJson(x))),
    );
  }
}

class ProjectItem {
  ProjectItem({
    required this.id,
    required this.projectName,
    required this.serviceType,
    required this.projectType,
    required this.projectLocation,
    required this.projectGrade,
    required this.totalBudget,
    required this.description,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.attachments,
    required this.user,
  });

  final int id;
  final String projectName;
  final String serviceType;
  final String projectType;
  final String projectLocation;
  final String projectGrade;
  final String totalBudget;
  final String description;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Attachment> attachments;
  final User? user;

  factory ProjectItem.fromJson(Map<String, dynamic> json) {
    return ProjectItem(
      id: json["id"] ?? 0,
      projectName: json["project_name"] ?? "",
      serviceType: json["service_type"] ?? "",
      projectType: json["project_type"] ?? "",
      projectLocation: json["project_location"] ?? "",
      projectGrade: json["project_grade"] ?? "",
      totalBudget: json["total_budget"] ?? "",
      description: json["description"] ?? "",
      userId: json["user_id"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      attachments: json["attachments"] == null
          ? []
          : List<Attachment>.from(
              json["attachments"]!.map((x) => Attachment.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class Attachment {
  Attachment({
    required this.id,
    required this.url,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String url;
  final int projectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json["id"] ?? 0,
      url: json["url"] ?? "",
      projectId: json["project_id"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
}
