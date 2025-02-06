import 'package:flutter/material.dart';
import 'package:news/models/comment.dart';
import 'package:news/services/services_comment.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  ServicesComment _repo = ServicesComment();
  List<Comment> _comments = List<Comment>.empty(growable: true);
  String? _selectedCity;
  final List<String> _cities = [
    'Morrinhos',
    'Reitoria',
    'Urutai',
    'Campos Belos',
    'Catalao',
    'Ceres',
    'Cristalina',
    'Hidrolandia',
    'Ipameri',
    'Ipora',
    'Posse',
    'Rio Verde',
    'Trindade'
  ];

  Future<List<Comment>> _fetchComments() async {
    return await _repo.getIfs(_selectedCity!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonFormField<String>(
            value: _selectedCity,
            items: _cities.map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCity = newValue;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select a city',
              labelStyle:
                  TextStyle(color: Colors.white), // Cor do texto do rótulo
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white), // Cor da borda quando habilitado
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color.fromARGB(
                        255, 223, 223, 223)), // Cor da borda quando focado
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            ),
            style: TextStyle(color: Colors.white), // Cor do texto selecionado
            dropdownColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Expanded(
          child: FutureBuilder(
        future: _fetchComments(),
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
                    final Uri _uri = Uri.parse(_comment.url);
                    if (await canLaunchUrl(_uri)) {
                      await launchUrl(_uri);
                    } else {
                      throw 'Could not launch $_uri';
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
      )),
    );
  }
}
