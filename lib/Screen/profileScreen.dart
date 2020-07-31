import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
              Text(
                'Profile',
                style: kDetailtextStyle.copyWith(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                    'assets/images/slice_2.png',
                  ),
                ),
                Text(
                  'Brian Parker',
                  style: kDetailtextStyle.copyWith(
                      color: Hexcolor('#000000'), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    followersCard(1, 'followers'),
                    SizedBox(
                      width: 30,
                    ),
                    followersCard(1, 'Recipe'),
                    SizedBox(
                      width: 30,
                    ),
                    followersCard(1, 'Review'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: width * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: RaisedButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () {},
                        color: Hexcolor('#fE6D73'),
                        child: Text(
                          'Edit Profile',
                          style: headingtextStyle.copyWith(
                              fontSize: 18, color: Hexcolor('#333333')),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        color: Hexcolor('#fE6D73'),
                        onPressed: () {},
                        child: Icon(Icons.settings),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TabBar(
                  indicatorColor: Colors.red,
                  controller: _tabController,
                  tabs: [
                    Text(
                      'Recipie',
                      style:
                          kotherHeadertextStyle.copyWith(color: Colors.black),
                    ),
                    Text(
                      'Review',
                      style:
                          kotherHeadertextStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                chatCard(width),
                chatCard(width),
                chatCard(width),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget chatCard(double width) {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: Hexcolor('#fE6D73')),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/slice_2.png'),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Patrisha Pere',
                  style: headingtextStyle.copyWith(
                      fontSize: 18, color: Hexcolor('#333333')),
                ),
              ],
            ),
            Text(
              '35 Min ago',
              style: kotherHeadertextStyle.copyWith(fontSize: 10),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width * 0.7,
              child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra turpis elementumlk',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: kotherHeadertextStyle.copyWith(fontSize: 10)),
            )
          ],
        )
      ],
    ),
  );
}

Widget followersCard(int number, String text) {
  return Container(
    padding: EdgeInsets.all(3),
    height: 80,
    width: 80,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: Hexcolor('#ff6c74')),
    child: Column(
      children: [
        Text(
          number.toString(),
          style: kDetailtextStyle2,
        ),
        Text(
          text,
          style: kDetailtextStyle.copyWith(
              fontSize: 15, color: Hexcolor('#333333')),
        ),
      ],
    ),
  );
}
