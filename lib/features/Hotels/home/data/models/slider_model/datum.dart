import 'translation.dart';

class Datum {
  int? id;
  String? fromTime;
  String? toTime;
  String? imageUrl;
  String? title;
  String? content;
  List<Translation>? translations;

  Datum({
    this.id,
    this.fromTime,
    this.toTime,
    this.imageUrl,
    this.title,
    this.content,
    this.translations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        fromTime: json['from_time'] as String?,
        toTime: json['to_time'] as String?,
        imageUrl: json['image_url'] as String?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        translations: (json['translations'] as List<dynamic>?)
            ?.map((e) => Translation.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'from_time': fromTime,
        'to_time': toTime,
        'image_url': imageUrl,
        'title': title,
        'content': content,
        'translations': translations?.map((e) => e.toJson()).toList(),
      };
}
