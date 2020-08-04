import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:recipesaver/Screen/editProfile.dart';
import 'package:recipesaver/viewmodel/base_model.dart';

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
    return ViewModelProvider<BaseModel>.withConsumer(
      viewModel: BaseModel(),
      builder: (context, model, child) {
        return Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.person), onPressed: () {}),
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
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: CachedNetworkImageProvider(model.currentUser.imageurl ?? ""),
                      ),
                    ),
                    Center(
                      child: Text(
                        model.currentUser.fullname,
                        style: kDetailtextStyle.copyWith(
                            color: Hexcolor('#000000'),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Center(
                      child: Text(
                        model.currentUser.email,
                        style: kDetailtextStyle.copyWith(
                            color: Hexcolor('#333333'),
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()));
                          },
                          padding: EdgeInsets.all(10),
                          color: Hexcolor('#fE6D73'),
                          child: Text(
                            'Edit Profile',
                            style: headingtextStyle.copyWith(
                                fontSize: 18, color: Hexcolor('#F2F2F2')),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
//                    RaisedButton(
//                      padding: EdgeInsets.all(10),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(8)),
//                      color: Hexcolor('#fE6D73'),
//                      onPressed: () {},
//                      child: Icon(
//                        Icons.settings,
//                        color: Hexcolor('#F2F2F2'),
//                      ),
//                    )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Bio',
                        style: kotherHeadertextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        model.currentUser.bio ?? "Click edit profile to fill in your bio",
                        style: kotherHeadertextStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Hexcolor('#333333')),
                      ),
                    ),
//                    SizedBox(
//                      height: 30,
//                    ),
//                    littleInfo('assets/images/recipieProfile.svg', model.recipe.length == null ? "Loading" : model.recipe.length, 'Recipies'),
//                    SizedBox(
//                      height: 30,
//                    ),
//                    littleInfo('assets/images/starsProfile.svg', 4, 'likes'),
//                    SizedBox(
//                      height: 30,
//                    ),
//                    littleInfo('assets/images/savesForprofile.svg', 20, 'saves'),
//                    SizedBox(
//                      height: 30,
//                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

Widget littleInfo(String image, int number, String type) {
  return Row(
    children: [
      SvgPicture.asset(
        image,
        color: Colors.black,
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        '$number ',
        style: kotherHeadertextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Hexcolor('#333333')),
      ),
      Text(
        type,
        style: kotherHeadertextStyle.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Hexcolor('#333333')),
      ),
    ],
  );
}

// Widget chatCard(double width) {
//   return Container(
//     padding: EdgeInsets.all(8),
//     margin: EdgeInsets.only(bottom: 10),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: Hexcolor('#fE6D73').withOpacity(0.2)),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: AssetImage('assets/images/slice_2.png'),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Patrisha Pere',
//                   style: headingtextStyle.copyWith(
//                       fontSize: 18, color: Hexcolor('#333333')),
//                 ),
//               ],
//             ),
//             Text(
//               '35 Min ago',
//               style: kotherHeadertextStyle.copyWith(fontSize: 10),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               width: width * 0.7,
//               child: Text(
//                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra turpis elementumlk',
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: kotherHeadertextStyle.copyWith(fontSize: 10)),
//             )
//           ],
//         )
//       ],
//     ),
//   );
// }
