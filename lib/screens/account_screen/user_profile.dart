import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_store/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_store/routes/routes.dart';
import 'package:shop_store/screens/change_password/change_password.dart';
import 'package:shop_store/screens/edit_profile/edit_profile.dart';
import 'package:shop_store/screens/favorite_screen/favorite_screen.dart';

import '../../colors/colors.dart';
import '../../provider/app_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.topCenter,
                    height: 250.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(45, 35),
                        bottomRight: Radius.elliptical(45, 35),
                      ),
                      color: liteyellow,
                    ),
                    //child: Image.asset("assets/bgImage.jpg"),
                  ),
                  Container(
                    //color: Colors.white,

                    width: 400.0,
                    padding: EdgeInsets.only(top: 85, left: 55, right: 55),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.5),
                              blurRadius: 1,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(30),
                          ),
                          color: white),
                      height: 250,
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appProvider.getUserInformation.image == null
                              ? const Icon(
                                  Icons.person_outline,
                                  size: 120,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      appProvider.getUserInformation.image!),
                                  radius: 60,
                                ),
                          Text(
                            appProvider.getUserInformation.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: header.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                                color: black),
                          ),
                          Text(
                            appProvider.getUserInformation.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: 125,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(25),
                                ),
                                color: red),
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Edit',
                                  style: header.copyWith(
                                      fontSize: 22,
                                      color: black,
                                      letterSpacing: 3,
                                      fontWeight: FontWeight.w800),
                                ),
                                onPressed: () {
                                  Routes.instance.push(EditProfile(), context);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: red,
            ),
            title: Text(
              'Your Order',
              style: textFont.copyWith(
                  color: black, fontSize: 18, letterSpacing: 2),
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.favorite_outline,
          //     color: red,
          //   ),
          //   title: Text(
          //     'Return & Funds',
          //     style: textFont.copyWith(
          //         color: black, fontSize: 18, letterSpacing: 2),
          //   ),
          // ),
          ListTile(
            onTap: () {
              Routes.instance.push(FavoriteScreen(), context);
            },
            leading: Icon(
              Icons.favorite_outline,
              color: red,
            ),
            title: Text(
              'Favorite',
              style: textFont.copyWith(
                  color: black, fontSize: 18, letterSpacing: 2),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.shop),
          //   title: Text(
          //     'Manage Addressed',
          //     style: textFont.copyWith(
          //         color: black, fontSize: 18, letterSpacing: 2),
          //   ),
          // ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.info_outline,
              color: red,
            ),
            title: Text(
              'About Us',
              style: textFont.copyWith(
                  color: black, fontSize: 18, letterSpacing: 2),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.support_agent_outlined,
              color: red,
            ),
            title: Text(
              'Supported',
              style: textFont.copyWith(
                  color: black, fontSize: 18, letterSpacing: 2),
            ),
          ),

          ListTile(
            onTap: () {
              Routes.instance.push(ChangePassword(), context);
            },
            leading: Icon(
              Icons.password,
              color: red,
            ),
            title: Text(
              'Change Password',
              style: textFont.copyWith(
                  color: black, fontSize: 18, letterSpacing: 2),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              FireBaseAuthHelper.instance.signOut();

              setState(() {});
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Log out"),
          ),
          // Center(
          //   child: Container(
          //       height: 40,
          //       width: 120,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15), color: black),
          //       child: CupertinoButton(
          //           padding: EdgeInsets.zero,
          //           onPressed: () {
          //             FireBaseAuthHelper.instance.signOut();
          //             setState(() {});
          //           },
          //           child: Text(
          //             'LogOut',
          //             style: textFont.copyWith(
          //                 color: red,
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.w700,
          //                 letterSpacing: 3),
          //           ))),
          // ),

          SizedBox(
            height: 20,
          ),
          Text('Version 1.0.0'),
        ],
      ),
    );
  }
}
