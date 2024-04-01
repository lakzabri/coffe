import 'package:flutter/material.dart';



import '../utilis/NavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
            ),
            Center(
              child: Container(
                height: 40,
                width: 300,
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: "منتجاتي, المبيعات",
                    hintStyle: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 290), // Adjusted left padding
              child: Text(
                "اللوحة",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 570.0,
                height: 205.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF04764E).withOpacity(1.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Text(
                              "الاكثر مبيعا",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.monetization_on),
                          Spacer(),
                          Text(
                            "اجمالي المبيعات",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.monetization_on),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 190.0,
                            height: 99.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 30),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 60.0,
                                            width: 50.0,
                                            child: Image.asset(
                                              'assets/images/cupCoffe.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            "chocolate coffee",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "14.00 SR",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            width: 35,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF422006),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.elliptical(30, 30),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              Text("4.5")
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            children: [
                              Text(
                                "90,000 SR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "15,000 SR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                "اسبوعيا",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 245),
              child: Text(
                "طلبات اليوم",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [_comonde(), _comonde(), _comonde(), _comonde()],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250),
              child: Text(
                " منتجاتي",
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
              child: Column(
                children: [
                  Row(
                    children: [
                      _products(context),
                      _products(context),
                    ],
                  ),
                  Row(
                    children: [
                      _products(context),
                      _products(context),
                    ],
                  ),
                  Row(
                    children: [
                      _products(context),
                      _products(context),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _products(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.45,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black12, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "chocolate coffee",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "1 C Cacao Choclate",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "14.00 SR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text("4.5"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                height: 69.0,
                width: 39.0,
                child: Image.asset(
                  'assets/images/cupCoffe.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "تعديل",
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.8,
                    letterSpacing: -0.022,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _comonde() {
  return Container(
    margin: EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black12, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "chocolate coffee",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "X2",
                style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "24.00 SR",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "جدة",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.location_on)
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Container(
                height: 69.0,
                width: 39.0,
                child: Image.asset(
                  'assets/images/cupCoffe.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("علي البليهي"),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/hom.jpg',
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
