import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

Widget recipieCards(
    double height, String boximage, String recipiename, int likes) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: height * 0.6,
      width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            margin: EdgeInsets.only(right: 30),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: boximage == null ? Container() : Image.network(
              boximage,
              height: height * 0.58,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(recipiename,
                  style: headingtextStyle.copyWith(
                      fontSize: 18, color: Hexcolor('#333333'))),
              Spacer(),
              Text(likes.toString()),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: IconButton(
                    color: Colors.red,
                    icon: SvgPicture.asset(
                      'assets/images/like.svg',
                      color: Colors.red,
                    ),
                    onPressed: () {}),
              )
            ],
          )
        ],
      ),
    ),
  );
}
