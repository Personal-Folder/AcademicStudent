class Whatsapp {
  const Whatsapp({
    required this.id,
    required this.title,
    required this.description,
    required this.platform,
    required this.link,
    required this.image,
  });
  final int id;
  final String title;
  final String description;
  final String platform;
  final String link;
  final String image;
  Whatsapp.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        title = json['title'] ?? "",
        description = json['description'] ?? "",
        platform = json['platform'] ?? "",
        link = json['link'] ?? "",
        image = json['image'] ?? "";
}
