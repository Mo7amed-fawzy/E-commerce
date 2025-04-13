import 'package:e_commerce_app/components/declerations.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

enum AuthEnum { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-sreen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthEnum _auth = AuthEnum.signup;

  final _signUpkey = GlobalKey<FormState>();
  final _signInkey = GlobalKey<FormState>();
  final _forpkey = GlobalKey<FormState>();

  final TextEditingController _emailTxt = TextEditingController();
  final TextEditingController _passwordTxt = TextEditingController();
  final TextEditingController _nameTxt = TextEditingController();

  @override
  void dispose() {
    _emailTxt.dispose();
    _passwordTxt.dispose();
    _nameTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Declerations.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'wlcom',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              ListTile(
                tileColor:
                    _auth == AuthEnum.signup
                        ? Declerations.backgroundColor
                        : Declerations.greyBackgroundColor,
                title: const Text(
                  'new customer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: Declerations.secondaryColor,
                  value: AuthEnum.signup,
                  groupValue: _auth,
                  onChanged: (AuthEnum? val) {
                    setState(() {
                      _auth = val ?? AuthEnum.signup;
                    });
                  },
                ),
              ),

              if (_auth == AuthEnum.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Declerations.backgroundColor,
                  child: Form(
                    key: _signUpkey,
                    child: Column(
                      children: [
                        CustomText(controller: _nameTxt, hintText: 'Full Name'),
                        SizedBox(height: 10),
                        CustomText(controller: _emailTxt, hintText: 'Email'),
                        SizedBox(height: 10),
                        CustomText(
                          controller: _passwordTxt,
                          hintText: 'Password',
                        ),
                        SizedBox(height: 10),
                        CustomButton(text: 'Sign Up', onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor:
                    _auth == AuthEnum.signin
                        ? Declerations.backgroundColor
                        : Declerations.greyBackgroundColor,
                title: const Text(
                  'have an account?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: Declerations.secondaryColor,
                  value: AuthEnum.signin,
                  groupValue: _auth,
                  onChanged: (AuthEnum? val) {
                    setState(() {
                      _auth = val ?? AuthEnum.signin;
                    });
                  },
                ),
              ),
              if (_auth == AuthEnum.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Declerations.backgroundColor,
                  child: Form(
                    key: _signUpkey,
                    child: Column(
                      children: [
                        CustomText(controller: _emailTxt, hintText: 'Email'),
                        SizedBox(height: 10),
                        CustomText(
                          controller: _passwordTxt,
                          hintText: 'Password',
                        ),
                        SizedBox(height: 10),
                        CustomButton(text: 'Sign in', onTap: () {}),
                      ],
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
