import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController displaynameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController myController = TextEditingController();
  TextEditingController countrycodeController = TextEditingController();
  TextEditingController countryIsocodeController = TextEditingController();
  String? countryIsoCode;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Profile Settings',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).cardTheme.color),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(7))),
                  ),
                  onPressed: (() {}),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width <= 850
                  ? 0.8 * MediaQuery.of(context).size.width
                  : 0.3 * MediaQuery.of(context).size.width,
              child: Form(
                key: _formkey,
                onChanged: () {},
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: AssetImage('images/inapp/guest.jpg'),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Change Profile Picture',
                          style: TextStyle(color: Colors.cyan, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        minLines: 1,
                        controller: displaynameController,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelText: 'Display Name',
                          hintText: 'Display Name',
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Please enter a valid name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        controller: emailController,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelText: 'Email',
                          hintText: 'Email',
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        validator: (val) =>
                            val != null && val.isNotEmpty && val.contains("@")
                                ? null
                                : "Please enter a valid eamil",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntlPhoneField(
                        controller: phonenumberController,
                        decoration: InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelText: 'Phone Number',
                          hintText: 'Phone Number',
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        disableLengthCheck: true,
                        onChanged: (phone) {},
                        initialCountryCode: 'IN',
                        autovalidateMode: AutovalidateMode.disabled,
                        onSaved: (newValue) {
                          phonenumberController.text = newValue!.number;
                          countrycodeController.text = newValue.countryCode;
                          countryIsoCode = newValue.countryISOCode;
                        },
                        validator: (p0) {
                          if ((phonenumberController.text !=
                                  p0!.number.toString()) ||
                              (countrycodeController.text !=
                                  p0.countryCode.toString()) ||
                              (p0.toString().isEmpty)) {
                            return null;
                          } else {
                            return 'Please enter a valid phone number';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Text('Address'),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // TextFormField(
                      //   minLines: 1,
                      //   controller: streetController,
                      //   decoration: InputDecoration(
                      //     floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     labelText: 'Street no.',
                      //     hintText: 'Street no.',
                      //     filled: true,
                      //     fillColor: Theme.of(context).cardTheme.color,
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(7)),
                      //   ),
                      //   validator: (val) => val != null && val.isNotEmpty
                      //       ? null
                      //       : "Please enter street",
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   minLines: 1,
                      //   controller: pincodeController,
                      //   decoration: InputDecoration(
                      //     floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     labelText: 'Pincode',
                      //     hintText: 'Pincode',
                      //     filled: true,
                      //     fillColor: Theme.of(context).cardTheme.color,
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(7)),
                      //   ),
                      //   validator: (val) =>
                      //       val != null && val.isNotEmpty && val.length == 6
                      //           ? null
                      //           : "Please enter pincode",
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   minLines: 1,
                      //   controller: districtController,
                      //   decoration: InputDecoration(
                      //     floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     labelText: 'District',
                      //     hintText: 'District',
                      //     filled: true,
                      //     fillColor: Theme.of(context).cardTheme.color,
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(7)),
                      //   ),
                      //   validator: (val) => val != null && val.isNotEmpty
                      //       ? null
                      //       : "Please enter district",
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   minLines: 1,
                      //   controller: stateController,
                      //   decoration: InputDecoration(
                      //     floatingLabelAlignment: FloatingLabelAlignment.center,
                      //     labelText: 'State',
                      //     hintText: 'State',
                      //     filled: true,
                      //     fillColor: Theme.of(context).cardTheme.color,
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(7)),
                      //   ),
                      //   validator: (val) => val != null && val.isNotEmpty
                      //       ? null
                      //       : "Please enter state",
                      // ),
                    ],
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
