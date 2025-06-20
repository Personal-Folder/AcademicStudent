
class AppNotification {
  const AppNotification(
      {this.isRead, this.date, this.title, this.body, this.id});
  final String? title;
  final int? id;
  final int? isRead;
  final String? body;
  final DateTime? date;
  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
          title: json["title"],
          body: json["body"],
          isRead: json["is_read"],
          date: DateTime.parse(json["created_at"]));
  AppNotification copyWith({int? isRead}) => AppNotification(
      title: title, body: body, date: date, isRead: isRead ?? this.isRead);
}
