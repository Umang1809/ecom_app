import 'package:ecom_app/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      "DeviceVersion : ${LoginPage.pref!.getString("DeviceVersion")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      "DeviceSdkVersion : ${LoginPage.pref!.getString("DeviceSdkVersion")}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      "DeviceManufacturer : ${LoginPage.pref!.getString("DeviceManufacturer")}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.all(50),
                    child: Text(
                      "DeviceModelNUmber : ${LoginPage.pref!.getString("DeviceModelNUmber")}",
                      style: TextStyle(
                        fontSize: 20,
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
