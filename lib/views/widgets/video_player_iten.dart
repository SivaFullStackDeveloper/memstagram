import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';


class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        videoPlayerController.setVolume(100);
      });
  }
var visible = false;
  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
  var trolls = true;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child:InkWell(
                      onDoubleTap: (){

                      },
                      onTap: (){
                        setState(() {
                          visible=true;

                          if (videoPlayerController.value.isPlaying) {
                            videoPlayerController.pause();

                          } else {
                            videoPlayerController.play();
                            visible=false;
                          }
                        });
                      },
                        child: Stack(
                            children:
                        [

                          StreamBuilder(builder: ((context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(
                                color: Colors.red,
                              ));
                            } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                                snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),);
                              } else if (snapshot.hasData) {
                                return Text(snapshot.data.toString(),
                                    style: const TextStyle(
                                        color: Colors.teal, fontSize: 36));
                              } else {
                                return const Text('Error');
                              }
                            } else {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Center(child: CircularProgressIndicator(
                                color: Colors.red,
                                )),

                                  ],
                                ),
                              );
                            }
                          })),

                          videoPlayerController.value.isBuffering==true? Center(child: CircularProgressIndicator(
                          color: Colors.red,
                        )):VideoPlayer(videoPlayerController),
                          Visibility(
                            visible: visible,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.pause_circle,size: 100,),
                            ),
                          )
                        ]

                        )),



          );
  }
}
