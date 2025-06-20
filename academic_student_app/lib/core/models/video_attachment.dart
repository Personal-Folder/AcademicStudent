// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoEnrollment {
  final String title;
  final String viewerLink;
  VideoEnrollment({
    required this.title,
    required this.viewerLink,
  });

  VideoEnrollment copyWith({
    String? title,
    String? viewerLink,
  }) {
    return VideoEnrollment(
      title: title ?? this.title,
      viewerLink: viewerLink ?? this.viewerLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'viewer_link': viewerLink,
    };
  }

  factory VideoEnrollment.fromMap(Map<String, dynamic> map) {
    return VideoEnrollment(
      title: map['title'] as String,
      viewerLink: map['viewer_link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoEnrollment.fromJson(String source) => VideoEnrollment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VideoEnrollment(title: $title, viewerLink: $viewerLink)';

  @override
  bool operator ==(covariant VideoEnrollment other) {
    if (identical(this, other)) return true;

    return other.title == title && other.viewerLink == viewerLink;
  }

  @override
  int get hashCode => title.hashCode ^ viewerLink.hashCode;
}

List<VideoEnrollment> videovideoEnrollmentFromMapList(List source) {
  List<VideoEnrollment> videoEnrollment = [];
  for (var element in source) {
    videoEnrollment.add(VideoEnrollment.fromMap(element));
  }

  return videoEnrollment;
}
