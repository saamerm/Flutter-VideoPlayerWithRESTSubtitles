import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_with_subtitles/models/video_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';

class SelectedVideoDetailPage extends StatefulWidget {
    final String _selected;
    SelectedVideoDetailPage(this._selected);
  @override
  _SelectedVideoDetailPageState createState() => new _SelectedVideoDetailPageState();
}
class _SelectedVideoDetailPageState extends State<SelectedVideoDetailPage> {
  List<VideoDetails> list = List();
  var isLoading = false;
  VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Selected Video'),
        ),
        body: new Column(
          children:[
            new Spacer(flex: 5),
            new Container(
              child:
                new Container(
                  padding: EdgeInsets.only(top: 42, left: 5, right: 5, bottom: 50 ),
                  height: MediaQuery.of(context).size.height - 200.0,
                  width: MediaQuery.of(context).size.width - 66.0,
                  color: Colors.white,
                  child: 
                    Column(
                      children: <Widget>[
                        Text(
                          "Moment from meeting with Two Pillars",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                      ],
                    ),
                ),
              ),
              Spacer(flex: 3),
              SvgPicture.network(
                'https://static.chorus.ai/images/chorus-logo.svg',
                semanticsLabel: 'A shark?!',
                placeholderBuilder: (BuildContext context) => new Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              ),
              Spacer(flex: 1),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 5,
                color: Color.fromRGBO(47, 169, 214, 1),
              )
            ]
          )
    );
  }
}