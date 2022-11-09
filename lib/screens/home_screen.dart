import 'package:flutter/material.dart';
import 'package:memz/screens/edit_image_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("press to upload Image",style: TextStyle(
                fontSize: 18,
                color: Colors.white),),
            IconButton(
              icon: const Icon(
                Icons.upload_file,
              ),
              onPressed: () async {
                XFile? file = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditImageScreen(
                        selectedImage: file.path,
                      ),
                    ),
                  );
                }else{

                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
