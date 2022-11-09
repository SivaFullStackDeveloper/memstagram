import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memz/constants.dart';
import 'package:memz/controllers/search_controller.dart';

import 'package:memz/models/user.dart';
import 'package:memz/views/screens/profile_screen.dart';

import '../../api_services/api_services.dart';
import '../../models/search_model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Datum> searchprofile = [];
  TextEditingController searchController = TextEditingController();


@override
void initState(){
    super.initState();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor!,
        title: TextFormField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: buttonColor!),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: buttonColor!)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: buttonColor!)),
            filled: false,
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onChanged: (letter) {
            searchprofile.clear();
             search(letter).then((value) {
               if(value!=null){
                 setState((){
                   searchprofile = value.data!;
                 });

                 print(searchprofile[0].email);
               }
            });
          },
          //onFieldSubmitted: (value) {},
        ),
      ),
      body: searchprofile.isEmpty
          ? Center(
              child: Text(
                '  No Users found \nSearch for users!',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: searchprofile.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen2(

                          likes: "",
                          name: searchprofile[index].name.toString(),
                          following: searchprofile[index].following!.length.toString(),
                          followers: searchprofile[index].followers!.length.toString(),
                          profilepicture: searchprofile[index].profilepicture.toString(),
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading:Container(
                        height: 60,
                        width:60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        child: Hero(
                          
                          tag: "profile$index",
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(searchprofile[index].profilepicture.toString(),),

                      ),
                        ),),

                      title: Text(
                        searchprofile[index].name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
