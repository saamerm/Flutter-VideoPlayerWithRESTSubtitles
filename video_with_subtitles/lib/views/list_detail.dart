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

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    String url = "https://static.chorus.ai/api/${widget._selected}.json";
    final response = await http.get(url);
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
    _controller = VideoPlayerController.network(
        'https://static.chorus.ai/api/4d79041e-f25f-421d-9e5f-3462459b9934.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

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
                  padding: EdgeInsets.only(top: 42, left: 13, right: 13, bottom: 50 ),
                  height: MediaQuery.of(context).size.height - 200.0,
                  width: MediaQuery.of(context).size.width - 66.0,
                  color: Colors.white,
                  child: 
                    Column(
                      children: <Widget>[
                        Text(
                          "Moment from meeting with Two Pillars\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1)
                          ),
                        ),
                        new GestureDetector(
                            onTap: (){
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                // If the video is paused, play it.
                                _controller.play();
                              }
                            },
                          child:_controller.value.initialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller)
                            )
                          : Container(),
                        ),
                        isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: list.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if(index > 0 && list[index].speaker == list[index-1].speaker)
                                  {
                                    return ListTile(
                                      contentPadding: EdgeInsets.all(5.0),
                                      title: new Text(list[index].snippet),
                                    );
                                  }
                                  else
                                  {
                                    return ListTile(
                                      contentPadding: EdgeInsets.all(5.0),
                                      trailing: new Text(list[index].speaker),
                                      title: new Text(list[index].snippet),
                                    );
                                  }
                                }
                              ),
                            ),
                        Icon(Icons.keyboard_arrow_down)
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