import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecom_app/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    // theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("21212121212121212121212121212121212121");
    forInternetConnectivity();
  }

  void forInternetConnectivity() {
    setState(() {
      Connectivity().checkConnectivity().then((value) {
        print("KKKKKKKKKKKKKKKKKKKKKKKKKKK$value");
        if (value != ConnectivityResult.none) {
          forNavigation();
        } else {
          setState(() {
            showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
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
          });
        }
      });
      // Future.delayed(Duration(seconds: 3)).then((value) {
      //   var subscription =
      //       Connectivity().onConnectivityChanged.listen((Status) {
      //     if (Status == ConnectivityResult.mobile) {
      //       setState(() {
      //         forNavigation();
      //       });
      //       print("SSSSSSSSSSSSSSSSSSSSSS==MOBILE");
      //     } else if (Status == ConnectivityResult.wifi) {
      //       setState(() {
      //         forNavigation();
      //       });
      //       print("SSSSSSSSSSSSSSSSSSSSSS==WIFI");
      //     } else if (Status == ConnectivityResult.vpn) {
      //       setState(() {
      //         forNavigation();
      //       });
      //       print("SSSSSSSSSSSSSSSSSSSSSS==VPN");
      //     } else if (Status == ConnectivityResult.none) {
      //       print("SSSSSSSSSSSSSSSSSSSSSS==NOT CONNECTED");
      //
      //       setState(() {
      //         showDialog(
      //           useSafeArea: true,
      //           context: context,
      //           builder: (context) {
      //             return AlertDialog(
      //               backgroundColor: Colors.white,
      //               title: Text("No Internet Connection :("),
      //               icon: Icon(Icons.network_check_sharp),
      //               elevation: 50,
      //               actions: [
      //                 TextButton(
      //                     onPressed: () {
      //                       Navigator.pushReplacement(context,
      //                           MaterialPageRoute(
      //                         builder: (context) {
      //                           return SplashScreen();
      //                         },
      //                       ));
      //                     },
      //                     child: Text("Retry")),
      //                 TextButton(
      //                     onPressed: () {
      //                       SystemNavigator.pop();
      //                     },
      //                     child: Text("Close App")),
      //               ],
      //             );
      //           },
      //         );
      //       });
      //     }
      //   });
      // });
    });
  }

  void forNavigation() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ));
    });
    // Navigator.pushReplacement(context, MaterialPageRoute(
    //   builder: (context) {
    //     return LoginPage();
    //   },
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Lottie.asset("Animation/Ecommerce_App.json"),
      ),
    );
  }
}
