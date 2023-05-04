import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/constants/constant.dart';
import 'package:shop_store/screens/bottom_navigator/bottom_navigator.dart';

import 'package:shop_store/widgets/primary_button/primary_button.dart';

import 'package:shop_store/widgets/top_titles/top_titles.dart';

import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../routes/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                  title: 'Create Account',
                  subTitle: 'Welcome to Shopping Store'),
              SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    prefixIcon: Icon(
                      Icons.password_sharp,
                    ),
                    suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        child: Icon(Icons.visibility))),
              ),
              SizedBox(
                height: 25,
              ),
              PrimaryButton(
                  onPressed: () async {
                    bool isVaildated = signUpValidation(
                        email.text, password.text, name.text, phone.text);
                    if (isVaildated) {
                      bool isLogined = await FireBaseAuthHelper.instance.signUp(
                          name.text, email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(
                            const BottomNavigator(), context);
                      }
                    }
                  },
                  title: 'Create an Account'),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Already have an Account?',
                  style: header.copyWith(color: black, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Login',
                    style: header.copyWith(color: red, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
