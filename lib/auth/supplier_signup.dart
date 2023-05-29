// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/providers/auht_repo.dart';
import 'package:multi_store/widgets/auth_widgets.dart';
import 'package:multi_store/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  State<SupplierRegister> createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {
  late String storeName;
  late String email;
  late String password;
  late String storeLogo;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await AuthRepo.singUpWithEmailAndPassword(email, password);

          AuthRepo.sendEmailVerification();

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supp-images/$email.jpg');

          await ref.putFile(File(_imageFile!.path));
          _uid = AuthRepo.uid;

          storeLogo = await ref.getDownloadURL();

          AuthRepo.updateUserName(storeName);
          AuthRepo.updateProfileImage(storeLogo);

          await suppliers.doc(_uid).set({
            'storename': storeName,
            'email': email,
            'storelogo': storeLogo,
            'phone': '',
            'sid': _uid,
            'coverimage': '',
          });
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });

          await Future.delayed(const Duration(milliseconds: 100))
              .whenComplete(() {
            Navigator.of(context).pushReplacementNamed('/supplier_login');
          });
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });

          MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());

          /*  setState(() {
            processing = false;
          });

          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(
                _scaffoldKey, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(
                _scaffoldKey, 'The account already exists for that email.');
          } */
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please pick image first');
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Container(
          height: 800,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/onboard/bg3.jpg'),
                  //fit: BoxFit.cover
                  opacity: 0.5,
                  fit: BoxFit.fitHeight)),
          // ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const AuthHeaderLabel(headerLabel: 'Sign Up'),
                        if (_imageFile == null)
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 40),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.cyanAccent,
                                  backgroundImage:
                                      AssetImage('images/inapp/guest.jpg'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Gallery   | ',
                                    style: TextStyle(color: Colors.cyan),
                                    children: [
                                      TextSpan(
                                          text: ' Camera',
                                          style: TextStyle(color: Colors.cyan),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                (() => _pickImageFromCamera())),
                                    ],
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          (() => _pickImageFromGallery())),
                              )
                            ],
                          ),
                        if (_imageFile != null)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 40),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.cyanAccent,
                                  backgroundImage:
                                      FileImage(File(_imageFile!.path)),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Gallery   | ',
                                    style: TextStyle(color: Colors.cyan),
                                    children: [
                                      TextSpan(
                                          text: '  Camera',
                                          style: TextStyle(color: Colors.cyan),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap =
                                                (() => _pickImageFromCamera())),
                                    ],
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          (() => _pickImageFromGallery())),
                              )
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your full name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              storeName = value;
                            },
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Full Name',
                              hintText: 'Enter your Full Name',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email ';
                              } else if (value.isValidEmail() == false) {
                                return 'invalid email';
                              } else if (value.isValidEmail() == true) {
                                return null;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Email Address',
                              hintText: 'Enter your email',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: passwordVisible,
                            decoration: textFormDecoration.copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.cyan,
                                  )),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                          ),
                        ),
                        HaveAccount(
                          haveAccount: 'already have account? ',
                          actionLabel: 'Log In',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/supplier_login');
                          },
                        ),
                        processing == true
                            ? const CircularProgressIndicator(
                                color: Colors.cyan,
                              )
                            : AuthMainButton(
                                mainButtonLabel: 'Sign Up',
                                onPressed: () {
                                  signUp();
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
