import 'package:flutter/material.dart';
import 'package:news/models/comment.dart';
import 'package:news/services/services_comment.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ServicesComment _repo = ServicesComment();
  List<Comment> _comments = List<Comment>.empty(growable: true);

  Future<List<Comment>> _fetchComments() async {
    return await _repo.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor:
        //     Theme.of(context).primaryColor, // Definindo a cor de fundo
        body: FutureBuilder(
      future: _repo.getAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          _comments = snapshot.data!;
          return ListView.builder(
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              Comment _comment = _comments[index];
              return GestureDetector(
                onLongPress: () async {
                  if (await canLaunch(_comment.url)) {
                    await launch(_comment.url);
                  } else {
                    throw 'Could not launch ${_comment.url}';
                  }
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _comment.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _comment.subtitle,
                          style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey[700]),
                            SizedBox(width: 3),
                            Text(
                              _comment.campus,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey[700]),
                            SizedBox(width: 4),
                            Text(_comment.dateString),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    ));
  }
}
