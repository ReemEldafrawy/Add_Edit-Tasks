class Task {
  String title;
  String description;
  bool isFavourite;
  bool isChecked;

  Task({
    required this.title,
    required this.description,
    this.isFavourite = false,
    this.isChecked = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      isFavourite: json['isFavourite'] ?? false,
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isFavourite': isFavourite,
      'isChecked': isChecked,
    };
  }
}
