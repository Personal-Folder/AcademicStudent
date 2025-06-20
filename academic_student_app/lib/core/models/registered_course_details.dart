class RegisteredCourseDetails {
  final bool isSubscribe;
  final List<AttachmentEnrollment> attachments;
  final List<VideoEnrollment> videos;
  const RegisteredCourseDetails(
      {required this.attachments,
      required this.isSubscribe,
      required this.videos});
  RegisteredCourseDetails.fromJson(Map<String, dynamic> json)
      : isSubscribe = json["is_subscribe"],
        attachments = List.generate(
            json["enrollment"]["attachments"].length,
            (index) => AttachmentEnrollment.fromJson(
                json["enrollment"]["attachments"][index])),
        videos = List.generate(
            json["enrollment"]["videos"].length,
            (index) =>
                VideoEnrollment.fromJson(json["enrollment"]["videos"][index]));
}

class AttachmentEnrollment {
  const AttachmentEnrollment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.path,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
    required this.viewerLink,
  });
  final int id;
  final int courseId;
  final String title;
  final String description;
  final String path;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String link;
  final String viewerLink;
  AttachmentEnrollment.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? -1,
        courseId = json["courseId"] ?? -1,
        title = json["title"] ?? "",
        description = json["description"] ?? "",
        path = json["path"] ?? "",
        order = json["order"] ?? 1,
        createdAt = json["createdAt"] ?? DateTime.now(),
        updatedAt = json["updatedAt"] ?? DateTime.now(),
        link = json["link"] ?? "",
        viewerLink = json["viewerLink"] ?? "";
}

class VideoEnrollment {
  const VideoEnrollment({
    required this.id,
    required this.sessionId,
    required this.host,
    required this.title,
    required this.description,
    required this.path,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
    required this.viewerLink,
  });
  final int id;
  final int sessionId;
  final int host;
  final String title;
  final String description;
  final String path;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String link;
  final String viewerLink;
  VideoEnrollment.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? -1,
        sessionId = json["sessionId"] ?? -1,
        title = json["title"] ?? "",
        description = json["description"] ?? "",
        path = json["path"] ?? "",
        host = json["host"] ?? -1,
        order = json["order"] ?? -1,
        createdAt = json["createdAt"] ?? DateTime.now(),
        updatedAt = json["updatedAt"] ?? DateTime.now(),
        link = json["link"] ?? "",
        viewerLink = json["viewerLink"] ?? "";
}
