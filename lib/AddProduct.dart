import 'dart:convert';
import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_app/HomePage.dart';
import 'package:ecom_app/LoginPage.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? ProfilePhotoP;
  String? ImagePath;

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

  TextEditingController _ProductName = TextEditingController();
  TextEditingController _ProductPrice = TextEditingController();
  TextEditingController _ProductDescription = TextEditingController();

  bool ProductNameStatus = false;
  bool ProductPriceStatus = false;
  bool ProductDescriptionStatus = false;

  String? ProductNameError;
  String? ProductPriceError;
  String? ProductDescriptionError;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Color(0xFF265d51),
            body: SingleChildScrollView(
              child: Column(
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
                    ],
                  ),
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
                            ProductNameStatus = false;
                          });
                        },
                        controller: _ProductName,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            prefixIcon: Icon(Icons.production_quantity_limits),
                            prefixIconColor: Colors.green,
                            hintText: "Product Name ",
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3),
                            errorText:
                                ProductNameStatus ? ProductNameError : null),
                      ),
                    ),
                  ),
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
                            ProductPriceStatus = false;
                          });
                        },
                        controller: _ProductPrice,
                        keyboardType: TextInputType.phone,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            prefixIcon: Icon(Icons.currency_rupee),
                            prefixIconColor: Colors.green,
                            hintText: "Product Price ",
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3),
                            errorText:
                                ProductPriceStatus ? ProductPriceError : null),
                      ),
                    ),
                  ),
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
                            ProductDescriptionStatus = false;
                          });
                        },
                        controller: _ProductDescription,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
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
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            prefixIcon: Icon(Icons.description_outlined),
                            prefixIconColor: Colors.green,
                            hintText: "Product Description ",
                            hintStyle: TextStyle(
                                color: Colors.white60,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3),
                            errorText: ProductDescriptionStatus
                                ? ProductDescriptionError
                                : null),
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
                            onPressed: () {
                              String ProductName = "";
                              String ProductPrice = "";
                              String ProductDescription = "";

                              List<int> img =
                                  File(ImagePath!).readAsBytesSync();
                              String Photo = base64Encode(img);

                              setState(() {
                                ProductName = _ProductName.text;
                                ProductPrice = _ProductPrice.text;
                                ProductDescription = _ProductDescription.text;

                                if (ProductName.isEmpty) {
                                  ProductNameStatus = true;
                                  ProductNameError = "Please Enter Name";
                                } else if (ProductName.length < 5) {
                                  ProductNameStatus = true;
                                  ProductNameError = "Name is too Short!";
                                } else if (ProductPrice.isEmpty) {
                                  ProductPriceStatus = true;
                                  ProductPriceError =
                                      "Please Enter ProductPrice";
                                } else if (ProductDescription.isEmpty) {
                                  ProductDescriptionStatus = true;
                                  ProductDescriptionError =
                                      "Please Enter ProductDescription";
                                } else {
                                  forAddProduct(ProductName, ProductPrice,
                                      ProductDescription, Photo);
                                }
                              });
                            },
                            child: Text(
                              "   Add Product    ",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.green,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                  ),
                ],
              ),
            )));
  }

  Future<void> forAddProduct(String ProductName, String ProductPrice,
      String ProductDescription, String Photo) async {
    Map data = {
      "LoginId": LoginPage.pref!.getString("ID"),
      "ProductName": ProductName,
      "ProductPrice": ProductPrice,
      "ProductDescription": ProductDescription,
      "Photo": Photo,
    };
    var url =
        Uri.parse('https://umang360.000webhostapp.com/ECOM/addProduct.php');
    var response = await http.post(url, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> mmm = jsonDecode(response.body);

    // GetData gg = GetData.fromJson(mmm);
    AddProductResult gg = AddProductResult.fromJson(mmm);

    if (gg.connection == 1) {
      if (gg.result == 1) {
        HomePage.cnt = 0;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Product Added SuccessFully :)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      } else {}
    }
  }
}

class AddProductResult {
  int? connection;
  int? result;

  AddProductResult({this.connection, this.result});

  AddProductResult.fromJson(Map<String, dynamic> json) {
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
