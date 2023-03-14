import 'package:ecom_app/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  Future<bool> onWillPop() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Exit ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("NO")),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text("Yes"))
          ],
        );
      },
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // forInternetConnectivity();
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFF265d51),
        // appBar: AppBar(
        //   elevation: 20,
        //   leadingWidth: 80,
        //   centerTitle: true,
        //   backgroundColor: Colors.brown,
        //   title: Text("STORE 360",
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 30,
        //           fontWeight: FontWeight.bold,
        //           letterSpacing: 10)),
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15)),
        //   leading: IconButton(
        //       onPressed: () {
        //         setState(() {
        //           print('11111111111111111111');
        //           toggleMenu();
        //         });
        //       },
        //       icon: Icon(
        //         Icons.menu,
        //         color: Colors.black,
        //       )),
        // ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        "https://umang360.000webhostapp.com/ECOM/${LoginPage.pref!.getString("PROFILE")}",
                      ),
                      radius: 70,
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      "USER ID : ${LoginPage.pref!.getString("ID")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "USER NAME : ${LoginPage.pref!.getString("NAME")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "USER MOBILE NUMBER : ${LoginPage.pref!.getString("NUMBER")}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "USER EMAIL : ${LoginPage.pref!.getString("EMAIL")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "USER PASSWORD : ${LoginPage.pref!.getString("PASSWORD")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
