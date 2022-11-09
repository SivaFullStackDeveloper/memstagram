import 'package:flutter/material.dart';
import 'package:memz/constants.dart';
import 'package:memz/controllers/video_controller.dart';
import 'package:memz/views/screens/comment_screen.dart';
import 'package:memz/views/widgets/circle_animation.dart';
import 'package:memz/views/widgets/video_player_iten.dart';
import 'package:video_player/video_player.dart';

import 'confirm_screen.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25), child: Text("image")),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    fit: BoxFit.cover,
                  ),
                  ))
        ],
      ),
    );
  }

var url = [

  "http://techslides.com/demos/sample-videos/small.webm",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4"
];

  var trolls = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeData defaultTheme = Theme.of(context);

    return Scaffold(
        body:
            trolls?GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: buttonColor!,
      child:PageView.builder(
                  itemCount: url.length,
                  controller: PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [

                        VideoPlayerItem(
                                videoUrl: url[index].toString(),
                              ),



                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        style:TextButton.styleFrom(
                                            backgroundColor: !trolls?buttonColor:Colors.transparent,
                                            primary: Colors.black12),//ripple
                                        onPressed: (){
                                          setState((){
                                            trolls = false;
                                          });
                                        }, child: Text("Memes",style:TextStyle(
                                        color:Colors.white,
                                        fontSize: 20

                                    ))),

                                    Text("|",style:TextStyle(
                                        color:Colors.white,
                                        fontSize: 30

                                    )),
                                    TextButton(
                                        style:TextButton.styleFrom(
                                            backgroundColor: trolls?buttonColor:Colors.transparent,
                                            primary: Colors.black12),
                                        onPressed: (){
                                          setState((){
                                            trolls = true;
                                          });
                                        }, child: Text("Trolls",style:TextStyle(
                                        color:Colors.white,
                                        fontSize: 20

                                    ))),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'username',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'caption',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.music_note,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "songName",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(top: size.height / 5),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          buildProfile(
                                            "",
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(height: 7),
                                              InkWell(
                                                onTap: () => {},
                                                child: Icon(
                                                  Icons.favorite,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () => Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => CommentScreen(
                                                      id: "",
                                                    ),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.comment,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 7),

                                            ],
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.reply,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 7),


                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: CircleAnimation(
                                              child: buildMusicAlbum("photo"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
              )

    ):Container(
              child:Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style:TextButton.styleFrom(
                                  backgroundColor: !trolls?buttonColor:Colors.transparent,
                                  primary: Colors.black12),//ripple
                              onPressed: (){
                                setState((){
                                  trolls = false;
                                });
                              }, child: Text("Memes",style:TextStyle(
                              color:Colors.white,
                              fontSize: 20

                          ))),

                          Text("|",style:TextStyle(
                              color:Colors.white,
                              fontSize: 30

                          )),
                          TextButton(
                              style:TextButton.styleFrom(
                                  backgroundColor: trolls?buttonColor:Colors.transparent,
                                  primary: Colors.black12),
                              onPressed: (){
                                setState((){
                                  trolls = true;
                                });
                              }, child: Text("Trolls",style:TextStyle(
                              color:Colors.white,
                              fontSize: 20

                          ))),

                        ],
                      ),
                    ),
                  ),
                  InstaList(),

                ],
              ),
            ),

        );
  }
}




class InstaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return
    //   ListView.builder(itemCount:dummyStoryData.length,itemBuilder: (context,index)=> index == 0 ? SizedBox(
    //   child: InstaStories(),
    //   height: deviceSize.height *0.15,
    // ):
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        //1st row

        Padding(
          padding: const EdgeInsets.fromLTRB(16.0,16.0,8.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40.0,width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=")
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("siva",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: null,
              )
            ],
          ),
        ),
        //2nd row
        InteractiveViewer(
          boundaryMargin: EdgeInsets.all(8.0),
          minScale: 0.1,
          maxScale: 1.6,
          onInteractionUpdate: (_)=>print("Interaction Updated"),
          child: ClipRRect(borderRadius: BorderRadius.circular(15),
            child: Flexible(
              fit: FlexFit.loose,
              child: Image.network("https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=",fit: BoxFit.cover,),
            ),
          ),
        ),
        //3rd row

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                      //FontAwesome
                      Icons.favorite
                  ),
                  SizedBox(width: 10,),
                  Icon(
                      //FontAwesome
                      Icons.comment
                  ),
                  SizedBox(width: 10,),
                  Icon(
                      //FontAwesome
                      Icons.send
                  )
                ],
              ),
              Icon(
                  //FontAwesome
                  Icons.bookmark
              )
            ],
          ),
        ),
        //4th Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Liked by Rajat Palankar and 568,444 others ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        //5th Row
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=')
                  ),
                ),
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a comment..."
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}
