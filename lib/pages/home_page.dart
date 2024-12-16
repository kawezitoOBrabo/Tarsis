import 'package:login/pages/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF10397B),
        title: const Text(
          'Pesquisar',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Lugar do feed '),
      ),
    );
  }
}
