import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

Container bottomSheet(Function itemTapped, int _selectedIndex) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topRight: Radius.circular(14)),
      boxShadow: [
        BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.0),
        topRight: Radius.circular(14.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/discover.svg',
                color: Colors.black,
              ),
              title: Text(
                "Discover",
                style: kotherHeadertextStyle.copyWith(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/recipe.svg'),
              title: Text(
                "Recipie",
                style: kotherHeadertextStyle.copyWith(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/saved.svg'),
              title: Text(
                "Saved",
                style: kotherHeadertextStyle.copyWith(fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/images.png',
                height: 25,
              ),
              title: Text(
                "Profile",
                style: kotherHeadertextStyle.copyWith(fontSize: 10),
              )),
        ],
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.brown,
        backgroundColor: Hexcolor('#FFFFFF'),
        onTap: itemTapped,
        fixedColor: Hexcolor('#FE6D73'),
      ),
    ),
  );
}
