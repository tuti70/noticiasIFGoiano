import 'package:flutter/material.dart';
import 'package:news/models/comment.dart';
import 'package:news/services/services_comment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ServicesComment _repo = ServicesComment();
  List<Comment> _comments = List<Comment>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'IF News',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _repo.getAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              _comments = snapshot.data!;
              return ListView.separated(
                  itemCount: _comments.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    Comment _comment = _comments[index];
                    return ListTile(
                      title: Text(_comment.title),
                      subtitle: Text(_comment.subtitle),
                    );
                  });
            }
          },
        ));
  }
}
