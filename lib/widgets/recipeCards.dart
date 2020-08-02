import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            child: boximage == null ? Container() : CachedNetworkImage(
              imageUrl: boximage,
              placeholder: (_,__) => SizedBox(height: height * 0.58,child: Center(child: CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation(Colors.red),),)),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(recipiename,
                    style: headingtextStyle.copyWith(
                        fontSize: 18, color: Hexcolor('#333333'))),
              ),
              Spacer(),
//              Text(likes.toString()),
              Container(
//                margin: EdgeInsets.only(right: 30),
//                child: IconButton(
//                    color: Colors.red,
//                    icon: SvgPicture.asset(
//                      'assets/images/like.svg',
//                      color: Colors.red,
//                    ),
//                    onPressed: () {}),
              )
            ],
          )
        ],
      ),
    ),
  );
}
