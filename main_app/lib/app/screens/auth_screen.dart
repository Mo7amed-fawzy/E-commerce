import 'package:e_commerce_app/app/services/auth_service.dart';
import 'package:e_commerce_app/components/declarations.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:e_commerce_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

enum AuthEnum { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routName = '/auth-sreen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthEnum _auth = AuthEnum.signup;

  final _signUpkey = GlobalKey<FormState>();
  final _signInkey = GlobalKey<FormState>();
  // ignore: unused_field
  final _forpkey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

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

  void signUpUser() {
    _authService.signUpUser(
      context: context,
      email: _emailTxt.text,
      password: _passwordTxt.text,
      name: _nameTxt.text,
    );
  }

  void signInUser() {
    _authService.signInUser(
      context: context,
      email: _emailTxt.text,
      password: _passwordTxt.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Declarations.greyBackgroundColor,
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
                        ? Declarations.backgroundColor
                        : Declarations.greyBackgroundColor,
                title: const Text(
                  'new customer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: Declarations.secondaryColor,
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
                  color: Declarations.backgroundColor,
                  child: Form(
                    key: _signUpkey,
                    child: Column(
                      children: [
                        CustomText(controller: _nameTxt, hinTxt: 'Full Name'),
                        SizedBox(height: 10),
                        CustomText(controller: _emailTxt, hinTxt: 'Email'),
                        SizedBox(height: 10),
                        CustomText(
                          controller: _passwordTxt,
                          hinTxt: 'Password',
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpkey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor:
                    _auth == AuthEnum.signin
                        ? Declarations.backgroundColor
                        : Declarations.greyBackgroundColor,
                title: const Text(
                  'have an account?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: Declarations.secondaryColor,
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
                  color: Declarations.backgroundColor,
                  child: Form(
                    key: _signInkey,
                    child: Column(
                      children: [
                        CustomText(controller: _emailTxt, hinTxt: 'Email'),
                        SizedBox(height: 10),
                        CustomText(
                          controller: _passwordTxt,
                          hinTxt: 'Password',
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign in',
                          onTap: () {
                            if (_signInkey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        ),
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
