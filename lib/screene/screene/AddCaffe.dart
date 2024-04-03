import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utilis/NavBar.dart';

class AddCaffe extends StatefulWidget {
  const AddCaffe({Key? key}) : super(key: key);

  @override
  _AddCaffeState createState() => _AddCaffeState();
}

class _AddCaffeState extends State<AddCaffe> {
  File? _image;

  List<String> _items = [];
  final TextEditingController _controller = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        if (isStart) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة المقهى'),
      ),
      bottomNavigationBar: NavBar(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Change Profile Photo'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Take a Photo'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _pickImage(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text('Choose from Gallery'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    _pickImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: _image == null
                              ? Icon(
                                  Icons.camera_alt_outlined,
                                  size: 25,
                                  color: Color(0xFF04764E),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 180),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "تعديل",
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                letterSpacing: -0.022,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          Icon(Icons.edit)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 230),
                  child: Text(
                    " اسم المقهى",
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
                  child:  TextField(
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Coffee name",
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
                Padding(
                  padding: const EdgeInsets.only(left: 230),
                  child: Text(
                    "وصف المقهى",
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
                  height: 130,
                  width: 350,
                  child: TextField(
                    textAlign: TextAlign.right,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description of coffee",
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
                  padding: const EdgeInsets.only(left: 200),
                  child: Text(
                    "الموقع الالكتروني",
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
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "website",
                      hintStyle: TextStyle(
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w800,
                      ),
                      contentPadding: EdgeInsets.only(top: 8, right: 9),
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF04764E),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Icon(
                          Icons.public,
                          color: Colors.white,
                        ),
                      ),
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
                  padding: const EdgeInsets.only(left: 230),
                  child: Text(
                    "حسابات المقهى",
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          height: 40,
                          width: 180,
                          child: TextField(
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintText: "Facebook",
                              hintStyle: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                height: 1.5,
                                letterSpacing: 1,
                              ),
                              contentPadding: EdgeInsets.only(top: 8, right: 9),
                              prefixIcon: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color(0xFF04764E),
                                ),
                                child: const Icon(
                                  Icons.facebook,
                                  color: Colors.white,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 40,
                        width: 170,
                        child: TextField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: "instagram",
                            hintStyle: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              height: 1.5,
                              letterSpacing: 1,
                            ),
                            contentPadding: EdgeInsets.only(top: 8, right: 9),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color(0xFF04764E),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.instagram,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 230),
                  child: Text(
                    " ساعات العمل",
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF04764E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'حدد وقت الانتهاء',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () => _selectTime(context, false),
                      ),
                      Text(
                        "الى",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      TextButton(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF04764E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'حدد وقت البدء',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () => _selectTime(context, true),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        " من",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        child: Container(
                          height: 20,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Color(0xFF04764E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'الايام',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
              ])),
    );
  }
}
