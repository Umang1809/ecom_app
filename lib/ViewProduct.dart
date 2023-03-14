import 'dart:convert';

import 'package:ecom_app/LoginPage.dart';
import 'package:ecom_app/UpdateProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  ViewProductResult? dd;
  String? Result;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forViewProduct();
  }

  Future<void> forViewProduct() async {
    DefaultCacheManager manager = new DefaultCacheManager();
    manager.emptyCache();

    Map data = {
      "LoginId": LoginPage.pref!.getString("ID"),
    };

    var url =
        Uri.parse('https://umang360.000webhostapp.com/ECOM/viewProduct.php');
    var response = await http.post(url, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> mm = jsonDecode(response.body);

    setState(() {
      dd = ViewProductResult.fromJson(mm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF265d51),
        body: dd == null
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.redAccent,
                backgroundColor: Colors.black,
                strokeWidth: 5,
              ))
            : dd!.result == 0
                ? Center(
                    child: Text("Dont Have Any Product :("),
                    // child: CircularProgressIndicator(
                    // color: Colors.redAccent,
                    // backgroundColor: Colors.black,
                    // strokeWidth: 5,
                    //)
                  )
                : Column(
                    children: [
                      // Result != null
                      //     ? Center(
                      //         child: Text("$Result"),
                      //       )
                      //     :
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   shrinkWrap: true, //
                      //   // itemExtent: 150,
                      //   padding: EdgeInsets.all(10),
                      //   itemCount: dd!.productdata!.length == null
                      //       ? 0
                      //       : dd!.productdata!.length,
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       elevation: 20,
                      //       margin: EdgeInsets.all(10),
                      //       child: ListTile(
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(25)),
                      //         // contentPadding: EdgeInsets.all(30),
                      //         leading: Image(
                      //             image: NetworkImage(
                      //                 "https://umang360.000webhostapp.com/ECOM/${dd!.productdata![index].pPHOTO}")),
                      //         tileColor: Colors.white,
                      //         title: Row(
                      //           children: [
                      //             Text("${dd!.productdata![index].pNAME}"),
                      //             SizedBox(
                      //               width: 20,
                      //             ),
                      //             Text("${dd!.productdata![index].pPRICE} INR"),
                      //           ],
                      //         ),
                      //         subtitle: Row(
                      //           children: [
                      //             Text("P.id : ${dd!.productdata![index].iD}"),
                      //             SizedBox(
                      //               width: 20,
                      //             ),
                      //             Text("U.id : ${dd!.productdata![index].uID}"),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          // height: 200,
                          // width: 200,
                          child: GridView.builder(
                            semanticChildCount: 2,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 30),
                            itemCount: dd!.productdata!.length == null
                                ? 0
                                : dd!.productdata!.length,
                            itemBuilder: (context, index) {
                              return GridTile(
                                child: Stack(children: [
                                  Container(
                                    // height: 300,
                                    decoration: ShapeDecoration(
                                        color: Color(0xFF7D8A65),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 80, 10, 10),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${dd!.productdata![index].pNAME}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 5),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "₹${dd!.productdata![index].pPRICE} INR",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 5),
                                          ),
                                        ],
                                      ),
                                    ]),
                                    color: Colors.transparent,
                                  ),
                                  Container(
                                    // height: 200,
                                    // width: 200,

                                    color: Colors.transparent,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 50),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 50,
                                      child: Image(
                                        image: NetworkImage(
                                            "https://umang360.000webhostapp.com/ECOM/${dd!.productdata![index].pPHOTO}"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(40, 210, 30, 20),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Productdata data = dd!.productdata![index];
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return UpdateProduct(
                                                    dd!.productdata![index]);

                                                // return UpdateProduct(
                                                //     dd!.productdata![index].iD,
                                                //     dd!.productdata![index]
                                                //         .pPHOTO,
                                                //     dd!.productdata![index]
                                                //         .pPRICE,
                                                //     dd!.productdata![index]
                                                //         .pDESC,
                                                //     dd!.productdata![index]
                                                //         .pNAME);
                                              },
                                            ));
                                          },
                                          child: Text("UPDATE",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            forDeleteProduct(index);
                                          },
                                          child: Text("DELETE",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
  }

  Future<void> forDeleteProduct(int index) async {
    Map data = {
      "ProductId": dd!.productdata![index].iD,
    };

    var url =
        Uri.parse('https://umang360.000webhostapp.com/ECOM/deleteProduct.php');
    var response = await http.post(url, body: data);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var map = jsonDecode(response.body);
    DeleteProductResult dlt = DeleteProductResult.fromJson(map);

    if (dlt.connection == 1) {
      if (dlt.result == 1) {
        forViewProduct();
      }
    }
  }
}

class ViewProductResult {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  ViewProductResult({this.connection, this.result, this.productdata});

  ViewProductResult.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? iD;
  String? uID;
  String? pNAME;
  String? pPRICE;
  String? pDESC;
  String? pPHOTO;

  Productdata(
      {this.iD, this.uID, this.pNAME, this.pPRICE, this.pDESC, this.pPHOTO});

  Productdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uID = json['UID'];
    pNAME = json['PNAME'];
    pPRICE = json['PPRICE'];
    pDESC = json['PDESC'];
    pPHOTO = json['PPHOTO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['UID'] = this.uID;
    data['PNAME'] = this.pNAME;
    data['PPRICE'] = this.pPRICE;
    data['PDESC'] = this.pDESC;
    data['PPHOTO'] = this.pPHOTO;
    return data;
  }
}

class DeleteProductResult {
  int? connection;
  int? result;

  DeleteProductResult({this.connection, this.result});

  DeleteProductResult.fromJson(Map<String, dynamic> json) {
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
