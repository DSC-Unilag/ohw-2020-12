import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/model/user.dart';
import 'package:recipesaver/viewmodel/editiprofileviewmodel.dart';
import 'package:recipesaver/widgets/customTexts.dart';
import 'package:recipesaver/widgets/showCamera.dart';

import '../constants.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController bioEditingCOntroller = TextEditingController();
  File image;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ViewModelProvider<EditProfileViewModel>.withConsumer(
      viewModel: EditProfileViewModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Hexcolor('#E5E5E5'),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 0,
              backgroundColor: Hexcolor('#E5E5E5'),
              title: Text('Edit Profile',
                  style:
                      kDetailtextStyle.copyWith(fontSize: 18, color: Colors.black)),
            ),
            body: Container(
              height: height,
              width: width,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Center(
                    child: Container(
                      height: 130,
                      width: 140,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 59,
                              backgroundImage: image == null
                                  ? AssetImage('assets/images/slice_2.png')
                                  : FileImage(image),
                            ),
                          ),
                          Positioned(
                              top: 85,
                              left: 90,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera,
                                  color: Hexcolor('#fE6D73'),
                                ),
                                onPressed: () {
                                  showCameraSelection(context, getImage);
                                },
                                iconSize: 30,
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                  textInput2('Name'),
                  nonContainerEdit(model.currentUser.fullname),
                  textInput2('Email'),
                  nonContainerEdit(model.currentUser.email),
                  textInput2('Username'),
                  nonContainerEdit(model.currentUser.username),
                  textInput2('Experience'),
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 20),
                    color: Colors.white,
                    child: TextField(
                      controller: bioEditingCOntroller,
                      maxLines: null,
                      cursorColor: Hexcolor('#fE6D73'),
                      expands: true,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    child: model.busy ? Center(child: CircularProgressIndicator()) : RaisedButton(
                      color: Hexcolor('#fE6D73'),
                      onPressed: () async{
                        await model.uploadData(recipe: User(
                          id: model.currentUser.id,
                          fullname: model.currentUser.fullname,
                          email: model.currentUser.email,
                          password: model.currentUser.password,
                          username: model.currentUser.username,
                          bio: bioEditingCOntroller.text
                        ), mfile: image);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Update Profile',
                        style: headingtextStyle.copyWith(
                          fontSize: 18,
                          color: Hexcolor('#F2F2F2'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

Widget nonContainerEdit(String text) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 20),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: kDetailtextStyle,
    ),
  );
}
