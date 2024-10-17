import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvm/screen/login.dart';
import 'package:mvvm/model/registrationmodel.dart';
import 'package:provider/provider.dart';

import '../model/cmnvwmdl.dart';

class RegistrationScreen extends StatefulWidget {
  late final String phoneNumber;
  //Register({required this.phoneNumber});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  CommonViewModel? vm = null;

  final nameController = new TextEditingController();
  final usernameController = new TextEditingController();
  final phoneController = new TextEditingController();
  final passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);
//  CommonViewModel vm = Provider.of<CommonViewModel>(context, listen: false);

    final NameField = TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final usernameField = TextFormField(
        autofocus: false,
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid username");
          }
          return null;
        },
        onSaved: (value) {
          usernameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final phoneField = TextFormField(
        autofocus: false,
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your phone");
          }
          // reg expression for email validation
          if (!RegExp("").hasMatch(value)) {
            return ("Please Enter a valid phone");
          }
          return null;
        },
        onSaved: (value) {
          phoneController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 252, 82, 31),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            String name = nameController.text;
            String Username = usernameController.text;
            String phone = phoneController.text;
            String Password = passwordEditingController.text;

            Future<String> message =
                vm!.register(name, Username, phone, Password);

            message.then((value) {
              log("qqqqqq===" + value.toString());
              if (value.toString().contains("Success")) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("reg success")));
              } else {
                log("inside failed...");
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("reg failed")));
              }
            }
            );
            
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      //  key: _formKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root

            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                //  key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(

                        // child: Image.asset(
                        //   "assets/man.png",
                        //   fit: BoxFit.contain,
                        // )
                        ),
                    SizedBox(height: 45),
                    NameField,
                    SizedBox(height: 20),
                    usernameField,
                    SizedBox(height: 20),
                    phoneField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
