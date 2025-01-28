import 'dart:convert';
import 'dart:io';
import 'package:news/models/comment.dart';
import 'package:http/http.dart' as http;

class ServicesComment {
  Future<List<Comment>> getAll() async {
    //Buscar ultimo ID de noticia salvo

    String url = "http://157.245.254.121/noticias/?lastId=4290";
    Map<String, String> Headers = {
      HttpHeaders.contentTypeHeader: "application/json'; charset=UTF-8;",
    };

    final response = await http.get(Uri.parse(url), headers: Headers);

    List<Comment> comments = List.empty(growable: true);

    if (response.statusCode == 200) {
      //Lista onde cada linha é um Map<String, dynamic>
      List mComments = jsonDecode(response.body);

      //Para cada linha, converte a linha Map<String, dynamic> em Objeto Post
      mComments.forEach((mComment) {
        comments.add(Comment.fromJson(mComment));
      });
      //Recupera a ultima noticia da lista
      //Atualiza o sharedPrefernece com o ultimo ID de noticia recuperado
    } else {
      Exception('Failed to load comments');
    }
    return comments;
  }
}
