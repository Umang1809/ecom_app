import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_app/AddProduct.dart';
import 'package:ecom_app/DeviceInfo.dart';
import 'package:ecom_app/LoginPage.dart';
import 'package:ecom_app/ProfileInfo.dart';
import 'package:ecom_app/ViewProduct.dart';
// import 'package:ecom_app/ProfileInfouct.dart';
import 'package:ecom_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomePage extends StatefulWidget {
  static int cnt = 0;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bodyy = [
    ViewProduct(),
    AddProduct(),
    ProfileInfo(),
    DeviceInfo(),
  ];

  String? ProfilePhoto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageCache.clear();
    imageCache.clearLiveImages();
    forInternetConnectivity();
    forGetPrefranceValue();
  }

  void forGetPrefranceValue() {
    setState(() {
      ProfilePhoto = LoginPage.pref!.getString("PROFILE");
    });
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

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
            child: AdvancedDrawer(
          backdropColor: Colors.blueGrey,
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            // NOTICE: Uncomment if you want to add shadow behind the page.
            // Keep in mind that it may cause animation jerks.
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 0.0,
            //   ),
            // ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Scaffold(
            appBar: AppBar(
              elevation: 5,
              centerTitle: true,
              titleSpacing: 5,
              backgroundColor: Color(0xFF265d51).withOpacity(0.1),
              title: Text('ECOM APP'),
              leading: IconButton(
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
            ),
            backgroundColor: Color(0xFF265d51),
            body: bodyy[HomePage.cnt],
          ),
          drawer: SafeArea(
            child: Container(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: 128.0,
                        height: 128.0,
                        margin: EdgeInsets.fromLTRB(90, 80, 90, 50),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          "https://umang360.000webhostapp.com/ECOM/$ProfilePhoto",
                          fit: BoxFit.cover,
                        )),
                    ListTile(
                      onTap: () {
                        setState(() {
                          HomePage.cnt = 0;
                          Future.delayed(Duration(
                            milliseconds: 200,
                          )).then((value) {
                            _advancedDrawerController.hideDrawer();
                          });
                        });
                      },
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          HomePage.cnt = 1;
                          Future.delayed(Duration(
                            milliseconds: 200,
                          )).then((value) {
                            _advancedDrawerController.hideDrawer();
                          });
                        });
                      },
                      leading: Icon(Icons.home),
                      title: Text('Add Product'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          HomePage.cnt = 2;
                          Future.delayed(Duration(
                            milliseconds: 200,
                          )).then((value) {
                            _advancedDrawerController.hideDrawer();
                          });
                        });
                      },
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text('Profile'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.favorite),
                      title: Text('Favourites'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          HomePage.cnt = 3;
                          Future.delayed(Duration(
                            milliseconds: 200,
                          )).then((value) {
                            _advancedDrawerController.hideDrawer();
                          });
                        });
                      },
                      leading: Icon(Icons.info),
                      title: Text('About Your Device'),
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          LoginPage.pref!.setBool("LoginStatus", false);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return SplashScreen();
                            },
                          ));
                        },
                        child: Text("LOG OUT")),
                    Spacer(),
                    DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: Text('Terms of Service | Privacy Policy'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
