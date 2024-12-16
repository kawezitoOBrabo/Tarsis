import 'package:login/db/shared_prefs.dart';
import 'package:login/pages/home_page.dart';
import 'package:login/pages/login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    bool userStatus = await SharedPrefs().getUser();

    if (userStatus) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 21, 40, 21),
      child: Image.network(
          'https://www.dionambiental.com.br/wp-content/uploads/2024/05/DIA-MUNDIAL-DA-RECICLAGEM-BLOG-1.png.webp'),
    );
  }
}
