class Task {
  final String id;
  final String title;
  final String description;
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'userId': userId,
    };
  }
}
