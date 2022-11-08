import 'package:flutter/material.dart';
import 'package:memz/constants.dart';
import 'package:memz/views/screens/auth/signup_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../api_services/api_services.dart';
import '../../../models/login_model.dart';
import '../../widgets/dialog.dart';
import '../home_screen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final storage = FlutterSecureStorage();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  var spin = false;
  var visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(

            children: [

              Image.asset(
                'images/logo.png',
                width: 500,
                height: 200,
                color: buttonColor,
              ),

              Text(
                'login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        //borderSide: BorderSide(color: buttonColor!)
                       ),
                    labelText: 'Username',
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
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
                          color: Colors.grey,
                        )),
                    labelStyle: TextStyle(color: Colors.grey),
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
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      spin = true;
                    });
                    if (_nameController.text.isEmpty) {
                      Dilog().showMyDialog(context, "please enter name");
                      setState(() {
                        spin = false;
                      });
                    } else if (_passwordController.text.isEmpty) {
                      Dilog().showMyDialog(context, "please enter password");
                      setState(() {
                        spin = false;
                      });
                    } else {
                      login(_nameController.text, _passwordController.text)
                          .then((value) async {
                        setState(() {
                          spin = false;
                        });
                        Login data = value;
                        if (data.login == false) {
                          setState(() {
                            spin = false;
                          });
                          Dilog()
                              .showMyDialog(context, value.message.toString());
                        } else if (data.token != null && data.login == true) {
                          await storage.write(key: "token", value: data.token);
                          print(_nameController.text.toString());
                          await storage.write(
                              key: "username", value: _nameController.text);

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        } else {
                          Dilog().showMyDialog(context, "Something went wrong");
                        }
                      });
                    }
                  },
                  child: Center(
                    child: !spin
                        ? Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
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
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    ),
                    child: Text(
                      'Register',
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
}
