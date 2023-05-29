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

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  final ImagePicker _picker = ImagePicker();

  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

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
          await AuthRepo.sendEmailVerification();

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('cust-images/$email.jpg');

          await ref.putFile(File(_imageFile!.path));
          _uid = AuthRepo.uid;

          profileImage = await ref.getDownloadURL();
          AuthRepo.updateUserName(name);
          AuthRepo.updateProfileImage(profileImage);
          await customers.doc(_uid).set({
            'name': name,
            'email': email,
            'profileimage': profileImage,
            'phone': '',
            'address': '',
            'cid': _uid
          });
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
          });
          await Future.delayed(const Duration(microseconds: 100)).whenComplete(
              () => Navigator.pushReplacementNamed(context, '/customer_login'));
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
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
                  image: AssetImage('images/onboard/bg2.jpg'),
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
                              name = value;
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
                                context, '/customer_login');
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
