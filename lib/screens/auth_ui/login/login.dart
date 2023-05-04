import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_store/colors/colors.dart';
import 'package:shop_store/constants/constant.dart';
import 'package:shop_store/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_store/screens/auth_ui/sign_up/sign_up.dart';
import 'package:shop_store/screens/bottom_navigator/bottom_navigator.dart';

import 'package:shop_store/widgets/primary_button/primary_button.dart';

import 'package:shop_store/widgets/top_titles/top_titles.dart';

import '../../../routes/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                  title: 'Login', subTitle: 'Welcome back to Shopping Store'),
              SizedBox(
                height: 46.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _passwordController,
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
                    bool isValidated = loginValidation(
                        _emailController.text, _passwordController.text);

                    if (isValidated) {
                      bool isLogin = await FireBaseAuthHelper.instance.login(
                          _emailController.text,
                          _passwordController.text,
                          context);
                      if (isLogin) {
                        Routes.instance
                            .pushAndRemoveUntil(BottomNavigator(), context);
                      }
                    }
                  },
                  title: 'Login'),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Do not have an Account?',
                  style: header.copyWith(color: black, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(SignUp(), context);
                  },
                  child: Text(
                    'Create an Account',
                    style: header.copyWith(color: red, fontSize: 16),
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
