import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/constants/assets_images.dart';
import 'package:shop_store/routes/routes.dart';
import 'package:shop_store/screens/auth_ui/login/login.dart';
import 'package:shop_store/screens/auth_ui/sign_up/sign_up.dart';
import 'package:shop_store/widgets/primary_button/primary_button.dart';
import 'package:shop_store/widgets/top_titles/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopTitles(title: 'Welcome', subTitle: 'Buy your groceries from home'),
          Center(
              child: Image.asset(
            AssetImages.instance.welcomeImage,
            fit: BoxFit.cover,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.facebook,
                  color: orangeAccent,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: Image.asset(
                  AssetImages.instance.googleLogo,
                  height: 40,
                  width: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          PrimaryButton(
            title: 'Login',
            onPressed: () {
              Routes.instance.push(Login(), context);
            },
          ),
          SizedBox(
            height: 18,
          ),
          PrimaryButton(
            title: 'Sign Up',
            onPressed: () {
              Routes.instance.pushAndRemoveUntil(SignUp(), context);
            },
          ),
        ],
      ),
    ));
  }
}
