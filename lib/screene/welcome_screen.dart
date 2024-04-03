import 'package:coffee/screene/screene/signin.dart';
import 'package:flutter/material.dart';

import '../utilsYOUN/Navigation_Bar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 40),
        decoration: const BoxDecoration(
            color: Color(0xFF04764E),
            image: DecorationImage(
              image: AssetImage("assets/images/images.jpg"),
              fit: BoxFit.cover,
              opacity: 0.3,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Easy Coffee",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  letterSpacing: -0.022,
                  color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            Column(
              children: [
                const Text(
                  " جاهز لتسليط الضوء على مقهاك؟ انطلق الآن وقدم تجربة قهوة فريدة للزبائن عبر ",
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    letterSpacing: -0.022,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "!Easy Coffee",
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      letterSpacing: -0.022,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                    height: 35,
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
                      },
                      child: const Text("تسجيل الدخول" ),
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
                    width: 300,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Navigation_Bar()),
                        );
                      },
                      child: const Text('اشتراك'),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
