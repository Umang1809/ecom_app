import 'dart:convert';
import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_app/LoginPage.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? ProfilePhotoP;
  String? ImagePath;

  TextEditingController _Name = TextEditingController();
  TextEditingController _MobileNumber = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _Password = TextEditingController();
  TextEditingController _ConfirmPassword = TextEditingController();

  bool PasswordEye = true;
  bool ConfirmPasswordEye = true;

  bool NameStatus = false;
  bool MobileNumberStatus = false;
  bool EmailStatus = false;
  bool PasswordStatus = false;
  bool ConfirmPasswordStatus = false;

  String? NameError;
  String? MobileNumberError;
  String? EmailError;
  String? PasswordError;
  String? ConfirmPasswordError;

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

  final picker = ImagePicker();
  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // ProfilePhoto = pickedFile as String?;

    if (pickedFile != null) {
      setState(() {
        // ProfilePhotoP = File(pickedFile.path);
        ImagePath = pickedFile.path;
      });
    }
  }

  void getImage1() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        // ProfilePhotoP = File(pickedFile.path);
        ImagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forInternetConnectivity();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFF265d51),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ));
          },
          child: Text("Back"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(50, 20, 50, 10),
                  child: ImagePath == null
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("Photoss/ProfilePhoto.png"),
                          radius: 70,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: FileImage(File(ImagePath!)),
                          radius: 70,
                        )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getImage();
                        });
                      },
                      icon: Icon(
                        Icons.photo,
                        color: Colors.white60,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          getImage1();
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white60,
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 20,
                  blur: 150,
                  color: Colors.black.withOpacity(.2),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        NameStatus = false;
                      });
                    },
                    controller: _Name,
                    keyboardType: TextInputType.text,
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
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.green,
                        hintText: "Enter Your Name",
                        hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                        errorText: NameStatus ? NameError : null),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 20,
                  blur: 150,
                  color: Colors.black.withOpacity(.2),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        EmailStatus = false;
                      });
                    },
                    controller: _Email,
                    keyboardType: TextInputType.text,
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
                        prefixIcon: Icon(Icons.email_rounded),
                        prefixIconColor: Colors.green,
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                        errorText: EmailStatus ? EmailError : null),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: BlurryContainer(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 20,
                  blur: 150,
                  color: Colors.black.withOpacity(.2),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        ConfirmPasswordStatus = false;
                      });
                    },
                    controller: _ConfirmPassword,
                    keyboardType: TextInputType.text,
                    obscureText: ConfirmPasswordEye,
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
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      prefixIconColor: Colors.green,
                      hintText: "Enter Confirm Password",
                      hintStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              ConfirmPasswordEye = !ConfirmPasswordEye;
                            });
                          },
                          child: Icon(
                            ConfirmPasswordEye
                                ? Icons.visibility_off
                                : Icons.visibility_outlined,
                            color: Colors.red.withOpacity(.4),
                          )),
                      errorText:
                          ConfirmPasswordStatus ? ConfirmPasswordError : null,
                    ),
                  ),
                ),
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
                          String Name = "";
                          String MobileNumber = "";
                          String Email = "";
                          String Password = "";
                          String ConfirmPassword = "";
                          List<int> img = File(ImagePath!).readAsBytesSync();
                          String ProfilePhoto = base64Encode(img);
                          setState(() {
                            Name = _Name.text;
                            MobileNumber = _MobileNumber.text;
                            Email = _Email.text;
                            Password = _Password.text;
                            ConfirmPassword = _ConfirmPassword.text;

                            if (Name.isEmpty) {
                              NameStatus = true;
                              NameError = "Please Enter Name";
                            } else if (Name.length < 5) {
                              NameStatus = true;
                              NameError = "Name is too Short!";
                            } else if (MobileNumber.isEmpty) {
                              MobileNumberStatus = true;
                              MobileNumberError = "Please Enter Mobile Number";
                            } else if (MobileNumber.length != 10) {
                              MobileNumberStatus = true;
                              MobileNumberError =
                                  "Please Enter Valid Mobile Number";
                            } else if (Email.isEmpty) {
                              EmailStatus = true;
                              EmailError = "Please Enter Email";
                            } else if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(Email)) {
                              EmailStatus = true;
                              EmailError = "Please Enter Valid Email";
                            } else if (Password.isEmpty) {
                              PasswordStatus = true;
                              PasswordError = "Please Enter Password";
                            } else if (Password.length < 8) {
                              PasswordStatus = true;
                              PasswordError =
                                  "Password Must be 8 character long.";
                            } else if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(Password)) {
                              PasswordStatus = true;
                              PasswordError =
                                  "Pleas Enter Minimum 1 Upper case, 1 lowercase, 1 Numeric Number, 1 Special Character";
                            } else if (ConfirmPassword.isEmpty) {
                              ConfirmPasswordStatus = true;
                              ConfirmPasswordError =
                                  "Please Enter ConfirmPassword";
                            } else if (Password != ConfirmPassword) {
                              ConfirmPasswordStatus = true;
                              ConfirmPasswordError =
                                  "Please Enter Both Password Same";
                            } else {}
                          });

                          Map data = {
                            "Name": Name,
                            "MobileNumber": MobileNumber,
                            "Email": Email,
                            "Password": Password,
                            "ProfilePhoto": ProfilePhoto
                          };

                          var url = Uri.parse(
                              'https://umang360.000webhostapp.com/ECOM/register.php');
                          var response = await http.post(url, body: data);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          print("202020202020202020202020202020");

                          // var url = Uri.parse(
                          //     'https://umang360.000webhostapp.com/ECOM/register.php');
                          //
                          // var response = await http.post(url, body: data);
                          // print("30000000000000000000000000303030");
                          // print('Response status: ${response.statusCode}');
                          // print('Response body: ${response.body}');
                          Map<String, dynamic> mmm = jsonDecode(response.body);

                          GetData gg = GetData.fromJson(mmm);

                          if (gg.connection == 1) {
                            if (gg.result == 1) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Register SuccessFully :)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Email Alredy Exists :(",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )));
                            }
                          }
                        },
                        child: Text(
                          "   Register    ",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
                    child: Text(
                      "Alredy Have An Account ? SIGN IN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.withOpacity(.5),
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

class GetData {
  int? connection;
  int? result;

  GetData({this.connection, this.result});

  GetData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
