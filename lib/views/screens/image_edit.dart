import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey globalKey = new GlobalKey();

  String headerText = "";
  String footerText = "";

   XFile ? _imageFile;
  XFile ?_image;
  // File _image = File( _imageFile.path );
  // File _imageFile = File( _imageFile.path );
  bool imageSelected = false;

  Random rng = new Random();


  Future getImage() async {

      final XFile? image;
      ImagePicker i = ImagePicker();
      image = await i.pickImage(source: ImageSource.gallery);
      try {


      } catch (platformException) {
        print(platformException.toString());
      }

      if (image != null) {
        setState((){
          imageSelected = true;
        });

      } else {

      }
      _image = image!;


      Directory('storage/emulated/0/'+'MemeGenerator')
          .create(recursive: true);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "images/memegenrator.png",
                height: 70,
              ),
              SizedBox(
                height: 14,
              ),
              RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: <Widget>[
                    _image != null
                        ? Image.file(
                      File(_image!.path),
                      height: 300,
                      fit: BoxFit.fitHeight,
                    )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              headerText.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black87,
                                  ),
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 8.0,
                                    color: Colors.black87,
                                  ),
                                ],),

                            ),
                          ),
                          Spacer(),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                footerText.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black87,
                                    ),
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 8.0,
                                      color: Colors.black87,
                                    ),
                                  ],),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              imageSelected
                  ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          headerText = val;
                        });
                      },
                      decoration: InputDecoration(hintText: "Header Text"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          footerText = val;
                        });
                      },
                      decoration: InputDecoration(hintText: "Footer Text"),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        //TODO
                        //takeScreenshot();
                      },
                      child: Text("Save"),
                    )
                  ],
                ),
              )
                  : Container(
                child: Center(
                  child: Text("Select image to get started"),
                ),
              ),

              _imageFile != null ? Image.file(File(_imageFile!.path)) : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  // akeScreenshot() async {
  //
  //   //RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
  //   ui.Image image = await RenderRepaintBoundary().toImage();
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   ByteData byteData = ByteData(image.width);
  //   await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   print(pngBytes);
  //   XFile imgFile = new XFile('$directory/screenshot${rng.nextInt(200)}.png');
  //   setState(() {
  //     _imageFile = imgFile as XFile;
  //   });
  //   _savefile(_imageFile!);
  //   //saveFileLocal();
  //   imgFile.writeAsBytes(pngBytes);
  // }t

  _savefile(XFile file) async {
   // await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }

  // _askPermission() async {
  //   Map<PermissionGroup, PermissionStatus> permissions =
  //   await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  // }
}