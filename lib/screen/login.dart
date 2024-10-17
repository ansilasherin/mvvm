import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvm/model/loginmodel.dart';
import 'package:mvvm/screen/rgstrr.dart';
import 'package:mvvm/screen/home.dart';
import 'package:provider/provider.dart';
import '../model/cmnvwmdl.dart';
import 'package:mvvm/screen/login.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool newuser;
//late String username;
  final _formKey = GlobalKey<FormState>();

  CommonViewModel? vm = null;

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);

    // String username;
    // String password;
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

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
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
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrange,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String Username = usernameController.text;
            String password = passwordController.text;

            final Future<Map<String, dynamic>> SuccessfullMessage =
                vm!.login(Username, password);

            SuccessfullMessage.then((response) async {
              log(response.toString());
              if (response['status']) {
                loginModel ls1 = response['user'];
                log("username ====" + ls1.username.toString());
                if (ls1.username == Username && ls1.password == password) {
                  log('success');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => home()));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("LOGIN SUCCESS")));
                } else {
                  log("failed");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("User Not FOund")));
                }
                // logindata.setBool('login', false);

                // logindata.setString('username', username);
              } else {
                log('Login Failde');
              }
            });
          }
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //     height: 200,
                    //     child: Image.network('https://picsum.photos/250?image=9'),
                    //     ),
                    SizedBox(height: 45),
                    usernameField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
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
