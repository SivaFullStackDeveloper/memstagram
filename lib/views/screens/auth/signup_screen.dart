import 'package:flutter/material.dart';
import 'package:memz/constants.dart';
import 'package:memz/controllers/auth_controller.dart';
import 'package:memz/views/screens/auth/login_screen.dart';
import 'package:memz/views/widgets/text_input_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_services/api_services.dart';
import '../../../models/register_model.dart';
import '../../widgets/dialog.dart';
import 'dart:io';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  var spin = false;
  var visible = false;
  var image = "";
  bool _agreedToTOS = true;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(
                'images/logo.png',
                width: 120,
                height: 120,
                color: buttonColor,
              ),
              Text(
                'Memestagram',
                style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Register',
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
                  cursorColor: buttonColor,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    //labelStyle: TextStyle(color: buttonColor),
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
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    //labelStyle: TextStyle(color: buttonColor),
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
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: Icon(
                          !visible ? Icons.visibility_off : Icons.visibility,
                          color: buttonColor,
                        )),
                    //labelStyle: TextStyle(color: buttonColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: buttonColor!)),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: backgroundColor,
                      value: true,
                      onChanged: (bool? value) {
                        value = true;
                      },
                    ),
                    const Text(
                      'I agree to the Terms of Services and Privacy Policy',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: buttonColor),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      spin = true;
                    });
                    if (_image != null) {
                      register(
                        _image == null
                            ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                            : 'https://c4.wallpaperflare.com/wallpaper/317/236/853/emoticons-awesome-face-memes-wallpaper-preview.jpg',
                        _usernameController.text,
                        _emailController.text,
                        _passwordController.text,
                      ).then((data) {
                        Register value = data;
                        print(value.registred);
                        print(value.message);
                        if (value.registred == false) {
                          setState(() {
                            spin = false;
                          });
                          Dilog()
                              .showMyDialog(context, value.message.toString());
                        } else if (value.registred == true) {
                          setState(() {
                            spin = false;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                          Dilog().showMyDialog2(
                              context, "Registered Successfully");
                          _usernameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          setState(() {
                            spin = false;
                          });

                          Dilog().showMyDialog(context, "Something went wrong");
                        }
                      });
                    } else {
                      setState(() {
                        spin = false;
                      });


                      Dilog().showMyDialog(
                          context, "please select profile picture");
                    }
                  },
                  child: Center(
                    child: !spin
                        ? Text(
                            'Register',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bottomsheet() {
  //   return showModalBottomSheet<void>(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
  //     ),
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 220,
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text("choose Photo",
  //                   style: TextStyle(
  //                     fontSize: 20.0,
  //                   )),
  //               SizedBox(height: 10.0),
  //               Divider(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   ElevatedButton.icon(
  //                     onPressed: () {
  //                       takephoto(ImageSource.camera);
  //                     },
  //                     label: Text(
  //                       "camera",
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                     icon: Icon(
  //                       Icons.camera,
  //                       size: 40,
  //                     ),
  //                   ),
  //                   ElevatedButton.icon(
  //                     onPressed: () {
  //                       takephoto(ImageSource.gallery);
  //                     },
  //                     label: Text(
  //                       "Gallery",
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                     icon: Icon(
  //                       Icons.image,
  //                       size: 40,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }


}
