import 'package:flutter/material.dart';
import 'package:video_with_subtitles/models/video.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_with_subtitles/views/list_detail.dart';

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  List<Video> list = List();
  var isLoading = false;
  void _openPage(String selected)
  {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return new SelectedVideoDetailPage(selected);
        },
      ), 
    );
  }
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://gist.githubusercontent.com/saamerm/b19235a8d06397a36eddd0d8f341574c/raw/133199dc9b034b5452e4459b27c8a7d7be8818a2/ListId.json");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
        .map((data) => new Video.fromJson(data))
        .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
  @override
  initState(){
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Video List"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      _openPage(list[index].id);
                    },
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].title),
                    trailing: new Image.network(
                      list[index].thumbnail,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }
              ) 
    );
  }
}