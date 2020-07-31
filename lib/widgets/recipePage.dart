import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

Widget fromRecipiePageCard(
    {String image, String title, String about, String author, Function onPressed, bool save}) {
  return Container(
    padding: EdgeInsets.only(right: 20),
    margin: EdgeInsets.only(bottom: 10),
    child: Card(
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image)
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kotherHeadertextStyle.copyWith(
                      color: Hexcolor('#333333')),
                ),
              ),
              SizedBox(
                  width: 168,
                  height: 38,
                  child: Text(
                    about,
                    style: kotherHeadertextStyle.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      'written by $author',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kotherHeadertextStyle.copyWith(fontSize: 10),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  save ? IconButton(
                      icon: SvgPicture.asset('assets/images/saved.svg'),
                      onPressed: onPressed) : Container()
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
