import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await customers.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  bool docExists = false;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() async {
      User user = FirebaseAuth.instance.currentUser!;
      print(googleUser!.id);
      print(FirebaseAuth.instance.currentUser!.uid);
      print(googleUser);
      print(user);

      docExists = await checkIfDocExists(user.uid);

      docExists == false
          ? await customers.doc(user.uid).set({
              'name': user.displayName,
              'email': user.email,
              'profileimage': user.photoURL,
              'phone': '',
              'address': '',
              'cid': user.uid
            }).then((value) => navigate())
          : navigate();
    });
  }

  void navigate() {
    Navigator.pushNamed(context, '/customer_home');
  }

  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Welcome Screen');
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
        height: 800,
        width: 200,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/onboard/bg6.jpg'),
                //fit: BoxFit.cover
                fit: BoxFit.fill)),
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
                    'WELCOME TO',
                    textStyle: textStyle,
                    colors: textColors,
                  ),
                  ColorizeAnimatedText(
                    'Multi-Store',
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
                      RotateAnimatedText('Multi-Store'),
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
                            CyanButton(
                                label: 'Log In',
                                onPressed: () {
                                  Navigator.pushNamed(
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
                                    Navigator.pushNamed(
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
                                  Navigator.pushNamed(
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
                                    Navigator.pushNamed(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                child: Container(
                  child: processing == true
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
                            setState(() {
                              processing = false;
                            });

                            await Future.delayed(
                                    const Duration(microseconds: 100))
                                .whenComplete(() => Navigator.pushNamed(
                                    context, '/customer_home'));
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: const Icon(
                              Icons.person,
                              size: 25,
                              color: Colors.lightBlueAccent,
                            ),
                          )),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)))),
        onPressed: onPresssed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50, width: 50, child: child),
              Text(
                'Anonymous',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
              // Text(
              //   label,
              //   style: const TextStyle(color: Colors.black),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
