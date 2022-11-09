import 'package:flutter/material.dart';

import '../../api_services/api_services.dart';
import '../../constants.dart';
import '../../models/user.dart';
import '../widgets/dialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController youtubelink = TextEditingController();
  final TextEditingController instagramlink = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  User ? userdetails ;
  final storage =  FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    user_details();
  }

  user_details()async{

    var name = await storage.read(key: 'username');
    print(name.toString()+'this the name from profile');



    user(name).then((value){

      if(value!=null){
        setState((){
          userdetails = value;
          _usernameController.text = userdetails!.name;
          _emailController.text = userdetails!.email;
          youtubelink.text = userdetails!.youtubelink;
          instagramlink.text = userdetails!.instagramlink;
        });

        print(userdetails!.email.toString());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(


          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  readOnly: true,
                  cursorColor: buttonColor,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: FaIcon(FontAwesomeIcons.userAstronaut),
                   labelStyle: TextStyle(color: buttonColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  readOnly: true,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon:  FaIcon(FontAwesomeIcons.mailBulk),
                   labelStyle: TextStyle(color: buttonColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    labelText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(

                  cursorColor: buttonColor,
                  controller: youtubelink,
                  decoration: InputDecoration(
                    prefixIcon: FaIcon(FontAwesomeIcons.youtube),

                  labelStyle: TextStyle(color: buttonColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    labelText: 'YouTube URL',
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: instagramlink,
                  decoration: InputDecoration(
                    prefixIcon:  FaIcon(FontAwesomeIcons.instagram),

                    labelStyle: TextStyle(color: buttonColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    labelText: 'Instagram URL',
                  ),
                ),
              ),



              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      spin = true;
                    });
                    if(youtubelink.text.toString().contains("youtube")){
                      edit(userdetails!.name,
                          youtubelink.text.toString(),
                          instagramlink.text.toString()
                      ).then((data){
                        Dilog().showMyDialog(context, "updated sucessfully");
                      });
                      setState(() {
                        spin = false;
                      });
                    }else{
                      Dilog().showMyDialog(context, "Please check your YouTue and Instagram URlS");
                      setState(() {
                        spin = false;
                      });
                    }


                  },
                  child: Center(
                    child: !spin
                        ? Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                        : CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

            ],
          ),

      ),
    ));
  }

  var spin = false;
  var visible = false;
}
