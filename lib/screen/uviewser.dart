import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../model/cmnvwmdl.dart';

class user extends StatefulWidget {
  const user({super.key});

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommonViewModel>(context, listen: false);
    vm.getusers();
    return Scaffold(
      appBar: AppBar(
        title: Text("DONE"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(vm.user.length.toString()),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: vm.user.length,
                    itemBuilder: (context, index) {
                      final data = vm.user[index];
                      //  return Text(data.name);
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 80,
                              //color: Colors.orange,
                              child: Center(
                                  child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Text("title =" + snapshot.data!.title),
                                        Text(
                                          "Name:  " + data.name.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Username:  " +
                                              data.username.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Phone:  " + data.phone.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Name:  " + data.password.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ]),
                                ],
                              ))));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
