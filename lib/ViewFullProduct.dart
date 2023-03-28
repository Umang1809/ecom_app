import 'package:ecom_app/HomePage.dart';
import 'package:ecom_app/ViewProduct.dart';
import 'package:flutter/material.dart';

class ViewFullProduct extends StatefulWidget {
  Productdata productdata;

  ViewFullProduct(Productdata this.productdata);

  @override
  State<ViewFullProduct> createState() => _ViewFullProductState();
}

class _ViewFullProductState extends State<ViewFullProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF265d51),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ));
          },
          child: Text("BACK"),
        ),
        body: Column(children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Image(
                  image: NetworkImage(
                      "https://umang360.000webhostapp.com/ECOM/${widget.productdata.pPHOTO}")),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("Product ID : ${widget.productdata.iD}")),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("Product NAME : ${widget.productdata.pNAME}")),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("Product PRICE : ${widget.productdata.pPRICE}")),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("Product Description : ${widget.productdata.pDESC}")),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text("Product UID : ${widget.productdata.uID}")),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: ElevatedButton(onPressed: () {

            }, child: Text("ORDER")),
          )
        ]),
      ),
    );
  }
}
