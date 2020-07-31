import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import '../constants.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  File image;
  final picker = ImagePicker();
  List variaties = ['America', 'Brithish', 'Carribean', 'Chinese', 'Nigerian'];
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  int selectedno = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Hexcolor('#F2F2F2'),
        body: Container(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    'Upload new recipe',
                    style: kDetailtextStyle.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/slice_2.png'),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCameraSelection(context, getImage);
                          },
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: image == null
                                  ? AssetImage(
                                      'assets/images/upload.png',
                                    )
                                  : FileImage(image),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textinput3('Name'),
                        Container(
                          height: 50,
                          child: TextFormField(
                            decoration: kInputBoxDecoration3,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textinput3('Description'),
                        Container(
                          height: 100,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            style:
                                kDetailtextStyle.copyWith(color: Colors.black),
                            decoration: kInputBoxDecoration3,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textinput3('Time'),
                        Container(
                          height: 50,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            style:
                                kDetailtextStyle.copyWith(color: Colors.black),
                            decoration: kInputBoxDecoration3,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textinput3('Ingredients'),
                        Container(
                          height: 50,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            style:
                                kDetailtextStyle.copyWith(color: Colors.black),
                            decoration: kInputBoxDecoration3,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        textinput3('Select Cusine'),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: variaties.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedno = index;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selectedno == index
                                            ? Hexcolor('#FE6D73')
                                            : Hexcolor('#FFFFFF'),
                                      ),
                                      child: Center(
                                        child: Text(
                                          variaties[index],
                                          style: kDetailtextStyle.copyWith(
                                            fontSize: 10,
                                            color: selectedno == index
                                                ? Hexcolor('#FFFFFF')
                                                : Hexcolor('#333333'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textinput3('Untensils used'),
                        Container(
                          height: 50,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            style:
                                kDetailtextStyle.copyWith(color: Colors.black),
                            decoration: kInputBoxDecoration3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget textinput3(String text) {
  return Text(
    text,
    style: kDetailtextStyle.copyWith(fontSize: 12),
  );
}

Future showCameraSelection(BuildContext context, Function getImage) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: (context),
      builder: (context) => Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  Text('Camera'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.insert_photo),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  Text('Gallery'),
                ],
              )
            ],
          )));
}
