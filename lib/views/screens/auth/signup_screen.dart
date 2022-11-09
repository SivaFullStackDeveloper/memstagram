import 'package:flutter/material.dart';
import 'package:memz/constants.dart';
import 'package:memz/views/screens/auth/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_services/api_services.dart';
import '../../../models/register_model.dart';
import '../../widgets/dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 60),
              Image.asset(
                'images/logo.png',
                width: 500,
                height: 200,
                color: buttonColor,
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
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
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
                  cursorColor: buttonColor,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                 ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
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
                    prefixIcon: const Icon(
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
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                       ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        ),
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue),
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
                              builder: (context) => const LoginScreen()));
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
                    }
                  },
                  child: Center(
                    child: !spin
                        ? const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : const CircularProgressIndicator(
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
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
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

bottomSheet() {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
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
              const Text("choose Photo",
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
              const SizedBox(height: 10.0),
              const Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                     // takephoto(ImageSource.camera);
                    },
                    label: const Text(
                      "camera",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    icon: const Icon(
                      Icons.camera,
                      size: 40,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                     // takephoto(ImageSource.gallery);
                    },
                    label: const Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    icon: const Icon(
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
