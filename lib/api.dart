import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<photos> photosList = [];
  Future<List<photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photos photo = photos(title: i['title'], url: i['url']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [Text("Hasnian Jafri")]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(children: [
        Text('data'),
        Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<photos>> snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data![index].url);
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                            snapshot.data![index].url,
                            scale: 2
                          ),
                          onBackgroundImageError: (exception, stackTrace) => {
                            print("error")
                          },
                       
                          
                          ),
                          title: Text(snapshot.data![index].title),
                        );
                      });
                }))
      ]),
    );
  }
}

class photos {
  String title, url;
  photos({required this.title, required this.url});
}
