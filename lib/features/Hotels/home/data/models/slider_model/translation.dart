class Translation {
  String? title;
  String? content;

  Translation({this.title, this.content});

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        title: json['title'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };
}
