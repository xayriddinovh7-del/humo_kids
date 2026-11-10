class ChildModel {
  final String id;
  final String name;
  final String groupName;
  final String kindergartenName;
  final String? avatarUrl;
  final int age;
  final bool isInKindergarten;
  final String? arrivalTime;

  const ChildModel({
    required this.id,
    required this.name,
    required this.groupName,
    required this.kindergartenName,
    this.avatarUrl,
    required this.age,
    this.isInKindergarten = true,
    this.arrivalTime,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      groupName: json['group_name'] as String? ?? '',
      kindergartenName: json['kindergarten_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      age: json['age'] as int? ?? 0,
      isInKindergarten: json['is_in_kindergarten'] as bool? ?? true,
      arrivalTime: json['arrival_time'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'group_name': groupName,
        'kindergarten_name': kindergartenName,
        'avatar_url': avatarUrl,
        'age': age,
        'is_in_kindergarten': isInKindergarten,
        'arrival_time': arrivalTime,
      };
}

class DailyReportModel {
  final String childId;
  final String date;
  final String mood; // 'A\'lo', 'Yaxshi', 'O\'rtacha'
  final String sleepDuration;
  final String mealsScore; // '100%', '80%'
  final String activitiesCompleted;
  final String? teacherComment;

  const DailyReportModel({
    required this.childId,
    required this.date,
    required this.mood,
    required this.sleepDuration,
    required this.mealsScore,
    required this.activitiesCompleted,
    this.teacherComment,
  });

  factory DailyReportModel.fromJson(Map<String, dynamic> json) {
    return DailyReportModel(
      childId: json['child_id']?.toString() ?? '',
      date: json['date'] as String? ?? '',
      mood: json['mood'] as String? ?? "A'lo",
      sleepDuration: json['sleep_duration'] as String? ?? '2 soat',
      mealsScore: json['meals_score'] as String? ?? '100%',
      activitiesCompleted: json['activities_completed'] as String? ?? '4 ta',
      teacherComment: json['teacher_comment'] as String?,
    );
  }
}

class FoodMenuItem {
  final String id;
  final String mealType; // 'Ertalabki nonushta', 'Tushlik', 'Kechki tamaddi'
  final String time;
  final String title;
  final String description;
  final String calories;
  final bool isCompleted;

  const FoodMenuItem({
    required this.id,
    required this.mealType,
    required this.time,
    required this.title,
    required this.description,
    required this.calories,
    this.isCompleted = true,
  });

  factory FoodMenuItem.fromJson(Map<String, dynamic> json) {
    return FoodMenuItem(
      id: json['id']?.toString() ?? '',
      mealType: json['meal_type'] as String? ?? '',
      time: json['time'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      calories: json['calories'] as String? ?? '',
      isCompleted: json['is_completed'] as bool? ?? true,
    );
  }
}

