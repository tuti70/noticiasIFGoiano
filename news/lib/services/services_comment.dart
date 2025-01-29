import 'dart:convert';
import 'dart:io';
import 'package:news/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesComment {
  Future<List<Comment>> getAll() async {
    //Recupera o último ID já recuperado na API
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lastNewsId = await prefs.getInt('lastNewsId');

    String url = "http://157.245.254.121/noticias/?lastId=$lastNewsId&limit=20";
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

      //Atualiza o sharedPrefernece com o ultimo ID de noticia recuperado
      lastNewsId = comments.last.idSite;
      prefs.setInt('lastNewsId', lastNewsId);
    } else {
      Exception('Failed to load comments');
    }
    return comments;
  }

  // Future<List<Comment>> getIfs() async {
  //   //Buscar ultimo ID de noticia salvo
  //   int? commentId;

  //   String url =
  //       "http://157.245.254.121/noticias/?lastId=${commentId}&campus=Morrinhos'";
  //   Map<String, String> Headers = {
  //     HttpHeaders.contentTypeHeader: "application/json'; charset=UTF-8;",
  //   };

  //   final response = await http.get(Uri.parse(url), headers: Headers);

  //   List<Comment> comments = List.empty(growable: true);

  //   void VewId() async {
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.setInt('vewId', 4289);
  //   }

  //   if (response.statusCode == 200) {
  //     //Lista onde cada linha é um Map<String, dynamic>
  //     List mComments = jsonDecode(response.body);

  //     //Para cada linha, converte a linha Map<String, dynamic> em Objeto Post
  //     mComments.forEach((mComment) {
  //       comments.add(Comment.fromJson(mComment));
  //     });

  //     //Recupera a ultima noticia da lista
  //     //Atualiza o sharedPrefernece com o ultimo ID de noticia recuperado
  //   } else {
  //     Exception('Failed to load comments');
  //   }
  //   return comments;
  // }
}
