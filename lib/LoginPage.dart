import 'dart:convert';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecom_app/HomePage.dart';
import 'package:ecom_app/RegisterPage.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static SharedPreferences? pref;
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _MobileNumber = TextEditingController();
  TextEditingController _Password = TextEditingController();

  bool PasswordEye = true;
  bool isLogin = false;

  bool MobileNumberStatus = false;
  bool PasswordStatus = false;

  String? MobileNumberError;
  String? PasswordError;

  @override
  void initState() {
    forInternetConnectivity();
    forPrefrence();
    forDeviceInfo();
  }

  Future<void> forPrefrence() async {
    LoginPage.pref = await SharedPreferences.getInstance();

    isLogin = LoginPage.pref!.getBool("LoginStatus") ?? false;
    if (isLogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ));
    } else {
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (context) {
      //     return login();
      //   },
      // ));
    }
  }

  void forInternetConnectivity() {
    var subscription = Connectivity().onConnectivityChanged.listen((Status) {
      if (Status == ConnectivityResult.mobile) {
        print("SSSSSSSSSSSSSSSSSSSSSS==MOBILE");
      } else if (Status == ConnectivityResult.wifi) {
        print("SSSSSSSSSSSSSSSSSSSSSS==WIFI");
      } else if (Status == ConnectivityResult.vpn) {
        print("SSSSSSSSSSSSSSSSSSSSSS==VPN");
      } else if (Status == ConnectivityResult.none) {
        print("SSSSSSSSSSSSSSSSSSSSSS==NOT CONNECTED");

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("No Internet Connection :("),
              icon: Icon(Icons.network_check_sharp),
              elevation: 50,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SplashScreen();
                        },
                      ));
                    },
                    child: Text("Retry")),
                TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text("Close App")),
              ],
            );
          },
        );
      }
    });
  }

  Future<void> forDeviceInfo() async {
    final deviceinfo = DeviceInfoPlugin();
    final androidinfo = await deviceinfo.androidInfo;
    final map = androidinfo.toMap();
    print(">>>>>>>>>>>>>>>>>>>>>>>>$map");

    LoginPage.pref!
        .setString("DeviceVersion", "${androidinfo.version.release}");
    LoginPage.pref!
        .setString("DeviceSdkVersion", "${androidinfo.version.sdkInt}");
    LoginPage.pref!
        .setString("DeviceManufacturer", "${androidinfo.manufacturer}");
    LoginPage.pref!.setString("DeviceModelNUmber", "${androidinfo.model}");
  }

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
              Container(
                  margin: EdgeInsets.all(50),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("Photoss/ProfilePhoto.png"),
                    radius: 70,
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 20,
                  blur: 150,
                  color: Colors.black.withOpacity(.2),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        MobileNumberStatus = false;
                      });
                    },
                    controller: _MobileNumber,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white60,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        // prefixText: "+91",
                        // prefixStyle: TextStyle(
                        //   fontSize: 20,
                        //   color: Colors.white60,
                        //   letterSpacing: 5,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        prefixIcon: Icon(Icons.phone),
                        prefixIconColor: Colors.green,
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                        errorText:
                            MobileNumberStatus ? MobileNumberError : null),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 20,
                  blur: 150,
                  color: Colors.black.withOpacity(.2),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        PasswordStatus = false;
                      });
                    },
                    controller: _Password,
                    keyboardType: TextInputType.text,
                    obscureText: PasswordEye,
                    obscuringCharacter: "*",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white60,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      // prefixText: "+91",
                      // prefixStyle: TextStyle(
                      //   fontSize: 20,
                      //   color: Colors.white60,
                      //   letterSpacing: 5,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      prefixIconColor: Colors.green,
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              PasswordEye = !PasswordEye;
                            });
                          },
                          child: Icon(
                            PasswordEye
                                ? Icons.visibility_off
                                : Icons.visibility_outlined,
                            color: Colors.red.withOpacity(.4),
                          )),
                      errorText: PasswordStatus ? PasswordError : null,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 200, top: 20),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: BlurryContainer(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 20,
                    blur: 400,
                    color: Colors.black.withOpacity(.2),
                    child: TextButton(
                        onPressed: () async {
                          String MobileNumber = "";
                          String Password = "";
                          setState(() {
                            MobileNumber = _MobileNumber.text;
                            Password = _Password.text;

                            if (MobileNumber.isEmpty) {
                              MobileNumberStatus = true;
                              MobileNumberError = "Please Enter Mobile Number";
                            } else if (MobileNumber.length != 10) {
                              MobileNumberStatus = true;
                              MobileNumberError =
                                  "Please Enter Valid Mobile Number";
                            } else if (Password.isEmpty) {
                              PasswordStatus = true;
                              PasswordError = "Please Enter Password";
                            }
                          });
                          Map LoginDataa = {
                            "Number": MobileNumber,
                            "Password": Password
                          };

                          var url = Uri.parse(
                              'https://umang360.000webhostapp.com/ECOM/login.php');
                          var response = await http.post(url, body: LoginDataa);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          Map<String, dynamic> mmm = jsonDecode(response.body);

                          LoginData dd = LoginData.fromJson(mmm);
                          // LoginData ddd = LoginData.fromJson(mmm);

                          if (dd.connection == 1) {
                            if (dd.result == 1) {
                              LoginPage.pref!.setBool("LoginStatus", true);
                              LoginPage.pref!
                                  .setString("ID", "${dd.userdata!.iD}");
                              LoginPage.pref!
                                  .setString("NAME", "${dd.userdata!.nAME}");
                              LoginPage.pref!.setString(
                                  "NUMBER", "${dd.userdata!.nUMBER}");
                              LoginPage.pref!
                                  .setString("EMAIL", "${dd.userdata!.eMAIL}");
                              LoginPage.pref!.setString(
                                  "PASSWORD", "${dd.userdata!.pASSWORD}");
                              LoginPage.pref!.setString(
                                  "PROFILE", "${dd.userdata!.pROFILE}");

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Login SuccessFully :)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )));

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Sorry User Not Founded :)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )));
                            }
                          }
                        },
                        child: Text(
                          "   Sign In   ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                      "___________________________________________________")),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ));
                    },
                    child: Text(
                      "New User ? Register Here",
                      style: TextStyle(
                        color: Colors.green.withOpacity(.4),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                        wordSpacing: 2,
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

class LoginData {
  int? connection;
  int? result;
  Userdata? userdata;

  LoginData({this.connection, this.result, this.userdata});

  LoginData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? nUMBER;
  String? eMAIL;
  String? pASSWORD;
  String? pROFILE;

  Userdata(
      {this.iD,
      this.nAME,
      this.nUMBER,
      this.eMAIL,
      this.pASSWORD,
      this.pROFILE});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    nUMBER = json['NUMBER'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    pROFILE = json['PROFILE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['NUMBER'] = this.nUMBER;
    data['EMAIL'] = this.eMAIL;
    data['PASSWORD'] = this.pASSWORD;
    data['PROFILE'] = this.pROFILE;
    return data;
  }
}
