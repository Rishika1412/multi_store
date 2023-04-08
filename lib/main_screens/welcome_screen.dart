import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/widgets/cyan_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const textColors = [
  Colors.yellowAccent,
  Colors.red,
  Colors.blueAccent,
  Colors.green,
  Colors.purple,
  Colors.teal
];

const textStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Acme');

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool processing = false;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/onboard/bg1.jpg'),
                fit: BoxFit.cover)),
        // ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'WELCOME',
                    textStyle: textStyle,
                    colors: textColors,
                  ),
                  ColorizeAnimatedText(
                    'My Store',
                    textStyle: textStyle,
                    colors: textColors,
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              // const SizedBox(
              //   height: 220,
              //   width: 300,
              //   child: Image(
              //     image: AssetImage('images/inapp/logo.gif'),
              //     colorBlendMode: BlendMode.screen,
              //   ),
              // ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Acme'),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('My Store'),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 40,
                            width: 40,
                            child: Image(
                                image: AssetImage('images/inapp/supplier.png')),
                          ),
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  'Suppliers',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // AnimatedLogo(controller: _controller),
                            // const SizedBox(
                            //   height: 40,
                            //   width: 40,
                            //   child: Image(
                            //       image:
                            //           AssetImage('images/inapp/supplier.png')),
                            // ),
                            CyanButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/supplier_login');
                                },
                                width: 0.30),
                            const SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CyanButton(
                                  label: 'Sign Up',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/supplier_signup');
                                  },
                                  width: 0.30),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  'Customer',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                            width: 40,
                            child: Image(
                                image: AssetImage('images/inapp/buyer.png')),
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // AnimatedLogo(controller: _controller),
                            // const SizedBox(
                            //   height: 40,
                            //   width: 40,
                            //   child: Image(
                            //       image:
                            //           AssetImage('images/inapp/supplier.png')),
                            // ),
                            CyanButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/customer_login');
                                },
                                width: 0.30),
                            const SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CyanButton(
                                  label: 'Sign Up',
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/customer_signup');
                                  },
                                  width: 0.30),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GoogleFacebookLogIn(
                        label: 'Google',
                        onPresssed: () {},
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          child: const Image(
                              height: 30,
                              width: 30,
                              image: AssetImage('images/inapp/google.jpg')),
                        ),
                      ),
                      GoogleFacebookLogIn(
                        label: 'Facebook',
                        onPresssed: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 50,
                          child: const Image(
                              height: 30,
                              width: 30,
                              color: Colors.white,
                              image: AssetImage('images/inapp/facebook.png')),
                        ),
                      ),
                      processing == true
                          ? const CircularProgressIndicator()
                          : GoogleFacebookLogIn(
                              label: 'Guest',
                              onPresssed: () async {
                                setState(() {
                                  processing = true;
                                });
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .whenComplete(() async {
                                  _uid = FirebaseAuth.instance.currentUser!.uid;
                                  await anonymous.doc(_uid).set({
                                    'name': '',
                                    'email': '',
                                    'profileimage': '',
                                    'phone': '',
                                    'address': '',
                                    'cid': _uid
                                  });
                                });

                                await Future.delayed(
                                        const Duration(microseconds: 100))
                                    .whenComplete(() =>
                                        Navigator.pushReplacementNamed(
                                            context, '/customer_home'));
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black,
                                child: const Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Colors.lightBlueAccent,
                                ),
                              ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(image: AssetImage('images/inapp/logo.jpg')),
    );
  }
}

class GoogleFacebookLogIn extends StatelessWidget {
  final String label;
  final Function() onPresssed;
  final Widget child;
  const GoogleFacebookLogIn(
      {Key? key,
      required this.child,
      required this.label,
      required this.onPresssed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPresssed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            // Text(
            //   label,
            //   style: const TextStyle(color: Colors.black),
            // )
          ],
        ),
      ),
    );
  }
}
