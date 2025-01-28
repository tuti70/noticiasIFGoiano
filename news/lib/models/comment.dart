// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  int idSite;
  String title;
  String subtitle;
  String url;
  String campus;
  String dateString;
  String dataPublicacao;

  Comment({
    required this.idSite,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.campus,
    required this.dateString,
    required this.dataPublicacao,
  });

  Comment copyWith({
    int? idSite,
    String? title,
    String? subtitle,
    String? url,
    String? campus,
    String? dateString,
    String? dataPublicacao,
  }) =>
      Comment(
        idSite: idSite ?? this.idSite,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        url: url ?? this.url,
        campus: campus ?? this.campus,
        dateString: dateString ?? this.dateString,
        dataPublicacao: dataPublicacao ?? this.dataPublicacao,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        idSite: json["idSite"],
        title: json["title"],
        subtitle: json["subtitle"],
        url: json["url"],
        campus: json["campus"],
        dateString: json["dateString"],
        dataPublicacao: json["dataPublicacao"],
      );

  Map<String, dynamic> toJson() => {
        "idSite": idSite,
        "title": title,
        "subtitle": subtitle,
        "url": url,
        "campus": campus,
        "dateString": dateString,
        "dataPublicacao": dataPublicacao,
      };
}
