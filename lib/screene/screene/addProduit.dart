import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../utilis/NavBar.dart';

class AddProduit extends StatefulWidget {
  const AddProduit({super.key});

  @override
  State<AddProduit> createState() => _AddProduitState();
}

class _AddProduitState extends State<AddProduit> {
  List<File> _images = [];
  List<String> _items = [];
  final TextEditingController _controller =
      TextEditingController(); // Add this line

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavBar(),
        appBar: AppBar(
          title: Text("اضافة منتج"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: EdgeInsets.all(15),
            width: 400,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xFF04764E),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 80,
                    ),
                    onPressed: () async {
                      await _pickImage(ImageSource.gallery);
                    },
                  ),
                  Container(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: FileImage(_images[index]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200), // Adjusted left padding
            child: Text(
              "اسم المنتج",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 35,
            width: 350,
            child: const TextField(
              textAlign: TextAlign.right,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Product name ",
                hintStyle: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w800,
                ),
                contentPadding: EdgeInsets.only(top: 8, right: 9),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200), // Adjusted left padding
            child: Text(
              "وصف المنتج",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            width: 350,
            child: TextField(
              textAlign: TextAlign.right,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Description of product",
                hintStyle: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w800,
                ),
                contentPadding: EdgeInsets.only(top: 8, right: 9),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color(0xFF04764E),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: " price",
                          hintStyle: TextStyle(
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                          contentPadding: EdgeInsets.only(top: 8, right: 9),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  width: 100,
                ),
                Text(
                  "الثمن",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Color(0xFF04764E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButton<String>(
                            hint: Text(
                              "Choose",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            items: <String>['متوفر', 'غير متوفر']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        )),
                    SizedBox(
                      width: 90,
                    ),
                    Text(
                      "المخزون",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 279),
              child: Text(
                "الصنف",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 35,
              width: 350,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Enter items ",
                  hintStyle: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w800,
                  ),
                  contentPadding: EdgeInsets.only(top: 8, left: 100),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                onSubmitted: (text) {
                  setState(() {
                    _items.add(text);
                    _controller.clear();
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _items
                      .map((item) => item.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.all(10),
                              height: 20,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Color(0xFF04764E),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container())
                      .toList(),
                )),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 35,
                width: 350,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('حفظ'),
                  style: TextButton.styleFrom(
                    minimumSize: Size(88, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF04764E),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 35,
                width: 350,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('نشر'),
                  style: TextButton.styleFrom(
                    minimumSize: Size(88, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF04764E),
                  ),
                )),
          ])
        ])));
  }
}
