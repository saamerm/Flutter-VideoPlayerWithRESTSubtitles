import 'package:flutter/material.dart';
import 'package:video_with_subtitles/models/video_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectedVideoDetailPage extends StatefulWidget {
    final String _selected;
    SelectedVideoDetailPage(this._selected);
  @override
  _SelectedVideoDetailPageState createState() => new _SelectedVideoDetailPageState();
}
class _SelectedVideoDetailPageState extends State<SelectedVideoDetailPage> {
  List<VideoDetails> list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    String url = "https://static.chorus.ai/api/${widget._selected}.json";
    final response =
        await http.get(url);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
        .map((data) => new VideoDetails.fromJson(data))
        .toList();
      list.sort((a, b)=>a.time.compareTo(b.time));
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  initState() {
      super.initState();
     _fetchData();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Selected Video"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].snippet),
                    trailing: new Text(list[index].speaker),
                  );
                }
              ) 
    );
  }
}