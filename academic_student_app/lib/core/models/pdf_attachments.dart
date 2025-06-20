// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttachmentEnrollment {
  final String title;
  final String viewerLink;
  final String link;
  AttachmentEnrollment({
    required this.title,
    required this.viewerLink,
    required this.link,
  });

  AttachmentEnrollment copyWith({
    String? title,
    String? viewerLink,
    String? link,
  }) {
    return AttachmentEnrollment(
      title: title ?? this.title,
      viewerLink: viewerLink ?? this.viewerLink,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'viewer_link': viewerLink,
      'link': link,
    };
  }

  factory AttachmentEnrollment.fromMap(Map<String, dynamic> map) {
    return AttachmentEnrollment(
      title: map['title'] as String,
      viewerLink: map['viewer_link'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentEnrollment.fromJson(String source) => AttachmentEnrollment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AttachmentEnrollment(title: $title, viewerLink: $viewerLink, link: $link)';

  @override
  bool operator ==(covariant AttachmentEnrollment other) {
    if (identical(this, other)) return true;

    return other.title == title && other.viewerLink == viewerLink && other.link == link;
  }

  @override
  int get hashCode => title.hashCode ^ viewerLink.hashCode ^ link.hashCode;
}

List<AttachmentEnrollment> attachmentEnrollmentFromMapList(List source) {
  List<AttachmentEnrollment> attachmentEnrollment = [];
  for (var element in source) {
    attachmentEnrollment.add(AttachmentEnrollment.fromMap(element));
  }

  return attachmentEnrollment;
}
