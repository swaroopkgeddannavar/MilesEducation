class Task {
  final String id;
  final String title;
  final String description;

  Task({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, String docId) {
    return Task(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
