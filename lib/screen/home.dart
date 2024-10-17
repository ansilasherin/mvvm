import 'package:flutter/material.dart';
import 'package:mvvm/screen/login.dart';
import 'package:mvvm/screen/uviewser.dart';
//import 'package:mvvvm/screens/login.dart';

//import 'package:mvvvm/screens/viewuser.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'HOME ',
          ),
          backgroundColor: Colors.deepOrange,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(35.0),
            children: [
              ListTile(
                title: Text('view user'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => user()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text('log out '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            SizedBox(
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                //color: product.color,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => user()));
                },
                child: Text(
                  'view users',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        )));
  }
}
