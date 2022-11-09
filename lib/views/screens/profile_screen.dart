import 'dart:convert';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memz/constants.dart';
import 'package:memz/controllers/profile_controller.dart';
import 'package:memz/views/screens/auth/login_screen.dart';
import 'package:memz/views/screens/home_screen.dart';
import '../../api_services/api_services.dart';
import '../../models/user.dart';
import '../widgets/dialog.dart';
import 'editprofile.dart';
class ProfileScreen2 extends StatefulWidget {
  final String ?name;
  final String ?following;
  final String ?followers;
  final String ?likes;
  final String ?profilepicture;

   ProfileScreen2({
    Key? key,
     this.name,
     this.followers,
     this.following,
     this.profilepicture,
     this.likes,
  }) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {


  @override
  void initState() {
    super.initState();
  }


  String dropdownvalue = 'Report';
  var items = [
    'Report',
    'Block',

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: const Icon(
          Icons.person_add_alt_1_outlined,
        ),
        actions:  [
          DropdownButton(
            underline: SizedBox(),

            icon: const Icon(Icons.more_horiz),


            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) => buttonColor)
                  ),
                  onPressed:()async{

                  },
                  child:Row(
                    children: [
                      Icon(items=="Report"?Icons.report:Icons.block,color:items=="Report"?Colors.white:Colors.red ,),
                      SizedBox(width:1),
                      Text(items,style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                      ),),
                    ],
                  ),

                ),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ],
        title: Text(
          widget.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: buttonColor!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.profilepicture!,
                            height: 100,
                            width: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                            errorWidget: (context, url, error) =>
                                const Icon(
                              Icons.error,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'following',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                             Text(
                              widget.following!,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'followers',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.followers!,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'likes',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                             Text(
                              widget.likes!,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 140,
                      height: 47,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {

                          },
                          child: Text(
                            'Follow',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // video list
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        String thumbnail = 'thumbnails';
                        return Text(thumbnail.toString());
                        // return CachedNetworkImage(
                        //   imageUrl: thumbnail,
                        //   fit: BoxFit.cover,
                        // );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}




class ProfileScreen extends StatefulWidget {

  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final storage =  FlutterSecureStorage();
User ? userdetails ;

File ?image ;
final _picker = ImagePicker();
bool showSpinner = false;
Future getImage()async{
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);

  if(pickedFile!= null ){
    image = File(pickedFile.path);
    setState(() {

    });
  }else {
    print('no image selected');
  }
}

Future getImageCamera()async{
  final pickedFile = await _picker.pickImage(source: ImageSource.camera , imageQuality: 80);

  if(pickedFile!= null ){
    image = File(pickedFile.path);
    setState(() {

    });
  }else {
    print('no image selected');
  }
}

Future<void> uploadImage ()async{

  setState(() {
    showSpinner = true ;
  });

  var stream  =  http.ByteStream(image!.openRead());
  stream.cast();

  var length = await image!.length();

  var uri = Uri.parse('http://10.0.2.2:8000/sivarama');

  var request = new http.MultipartRequest('POST', uri);

  request.fields['title'] = "Static title" ;

  var multiport = new http.MultipartFile(
      'data',
      stream,
      length);

  request.files.add(multiport);

  var response = await request.send() ;

  print(response.stream.toString());
  if(response.statusCode == 200){
    setState(() {
      showSpinner = false ;
    });
    print('image uploaded');
  }else {
    print('failed');
    setState(() {
      showSpinner = false ;
    });

  }

}

user_details()async{

    var name = await storage.read(key: 'username');
    print(name.toString()+'this the name from profile');



  user(name).then((value){

    if(value!=null){
      setState((){
        userdetails = value;
      });

     print(userdetails!.email.toString());
    }
  });

}
String dropdownvalue = 'logout';

// List of items in our dropdown menu
var items = [
  "Edit Profile",
  'logout',

];
  @override
  void initState() {
    super.initState();
    user_details();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        elevation: 0,

        actions:  [
          DropdownButton(
            underline: SizedBox(),

            icon: const Icon(Icons.more_horiz),


            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: TextButton(
                  style: ButtonStyle(
                 overlayColor: MaterialStateProperty.resolveWith((state)=>buttonColor)
                  ),
                     onPressed:()async{
                    if(items.toString()=="Edit Profile"){

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                    }else if(items.toString()=="logout"){
                      await storage.delete(key: "token");
                      await storage.delete(key: "username").then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                      });
                    }



                  },
                    child:Text(items,style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),),

                ),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ],
        title: Text(
          userdetails==null?"":userdetails!.name.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: buttonColor!,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Stack(
                              children: [
                                image!=null? ClipOval(
                                  child:Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                  ),
                                  child: Image.file(
                                      File(image!.path).absolute,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                  ),
                                )):ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:  userdetails == null?'':userdetails!.profilepicture.toString(),
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                  errorWidget: (context, url, error){
                                    return Center();
                                  }
                                ),
                              ),
                                Positioned(
                                  bottom: 0,
                                  left: 60,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(40))
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          bottomsheet();
                                        },
                                        icon:  Icon(
                                          Icons.add_a_photo,color: Colors.white,size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
            ]
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'following',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userdetails==null?"": userdetails!.following.length.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'followers',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userdetails==null?"":userdetails!.followers.length.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black54,
                              width: 1,
                              height: 15,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'likes',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.youtube),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Text(userdetails==null?"":userdetails!.youtubelink.toString(),style: TextStyle(
                                  color: Colors.blue
                              ),),
                            )

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(FontAwesomeIcons.instagram),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Text(userdetails==null?"":userdetails!.instagramlink.toString(),style: TextStyle(
                                color: Colors.blue
                              ),),
                            )

                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        // video list
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            String thumbnail = 'thumbnails';
                            return Text(thumbnail.toString());
                            // return CachedNetworkImage(
                            //   imageUrl: thumbnail,
                            //   fit: BoxFit.cover,
                            // );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }



  bottomsheet() {
    return showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 220,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("choose Photo",
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                SizedBox(height: 10.0),
                Divider(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        getImageCamera().then((value) {
                          if(image!=null){

                            uploadImage().then((data) {
                              Dilog()
                                  .showMyDialog(context, "Profile Picture Updated!!!");
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                              //   return ProfileScreen();
                              // }), (route) => false);
                            });
                          }
                        });
                      },
                      label: Text(
                        "camera",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      icon: Icon(
                        Icons.camera,
                        size: 40,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        getImage().then((value) {
                          if(image!=null){

                            uploadImage().then((data) {
                              Dilog()
                                  .showMyDialog(context, "Profile Picture Updated!!!");
                            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                            //   return ProfileScreen();
                            // }), (route) => false);
                            });
                          }
                        });

                      },
                      label: Text(
                        "Gallery",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      icon: Icon(
                        Icons.image,
                        size: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
  }

