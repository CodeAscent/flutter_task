import 'package:flutter/material.dart';
import 'package:flutter_task/api/app_api.dart';
import 'package:flutter_task/widgets/button.dart';
import 'package:flutter_task/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child:
                          Image.asset("assets/images/login_screen_logo.png")),
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.alternate_email,
                        color: Colors.grey,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 300,
                        child: RepeatedTextField(
                          validator: (val) => val == ""
                              ? "Please enter an email address"
                              : null,
                          controller: _emailController,
                          hint: "Email ID",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 300,
                        child: RepeatedTextField(
                          validator: (val) =>
                              val == "" ? "Please enter a Password" : null,
                          isVisible: !isVisible,
                          controller: _passwordController,
                          hint: "Password",
                          sufix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                          onPressed: () {}, child: Text("Forgot Password?"))
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        if (globalKey.currentState!.validate()) {
                          AppApi().login(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: CustomButton(
                        color: Colors.blue.shade700,
                        item: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        " OR ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {},
                      child: CustomButton(
                        color: Colors.grey.shade300,
                        item: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            Image.asset(
                                "assets/images/google-removebg-preview.png"),
                            SizedBox(width: 60),
                            Center(
                              child: Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New to Logistics?"),
                      TextButton(onPressed: () {}, child: Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
