import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImages extends StatefulWidget {
  const MultipleImages({Key? key}) : super(key: key);

  @override
  State<MultipleImages> createState() => _MultipleImagesState();
}

class _MultipleImagesState extends State<MultipleImages> {
  int icnt = 1;
  bool st = false;
  String? ImagePath;
  List<XFile> Images = [];
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // ProfilePhoto = pickedFile as String?;

    if (pickedFile != null) {
      setState(() {
        ImagePath = pickedFile.path;
        Images.add(XFile(ImagePath!));

        icnt++;
      });

      print("${Images}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.amber,),
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.black26,),
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.amber,),
            //   ],
            // ),Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.amber,),
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.black26,),
            //     Container(height: 200,width: 120,margin: EdgeInsets.all(5),color: Colors.amber,),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height*0.31,
              width: MediaQuery.of(context).size.width,
              // width: 300,
              // height: 300,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisExtent: 185,),
                itemCount: icnt,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 0.5)),
                    child: Images.length != index
                        ? InkWell(   onLongPress: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text("Are You Sure To Remove Image ?"),actions: [
                          TextButton(onPressed: () {

                            Navigator.pop(context);
                          }, child: Text("NO")),
                          TextButton(onPressed: () {

                            setState(() {
                              icnt-=1;
                              Images.removeAt(index);
                            });
                            Navigator.pop(context);
                          }, child: Text("YES")),
                        ],);
                      },);
                    },child: Image(image: FileImage(File(Images[index].path)),fit: BoxFit.fill,))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                icnt!=19?TextButton.icon(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(Icons.photo),
                                    label: Text("Add Image")):
                                    Text("You Cant Add More Images")
                              ]),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       getImage();
            //     },
            //     child: Icon(Icons.image)),
            // Images != null
            //     ? Wrap(
            //         children: Images.map((e) {
            //           return CircleAvatar(
            //             maxRadius: 100,
            //             backgroundImage: FileImage(File(e.path)),
            //           );
            //         }).toList(),
            //       )
            //     : Container(),
            // ElevatedButton(onPressed: () {
            //
            // }, child: Text("ADD ALL "))
            Container(child: DotsIndicator(
              dotsCount: Images.length==0?1:Images.length+1,
              position: icnt==1?0:icnt-2,
              // position: 2,
              decorator: DotsDecorator(
                color: Colors.black87, // Inactive color
                activeColor: Colors.redAccent,
              ),
            ),),
            ElevatedButton(onPressed: () {
              print("VVVVVVVVVVVVVVVVVVVVVV$icnt");
            }, child: Text("Hello"))
          ],
        ),
      ),
    );
  }
}
