import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tiz/pages/confirm_page.dart';
// import 'package:tiz/pages/list_page.dart';
import 'package:tiz/pages/register_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: BodyHome(),
        debugShowCheckedModeBanner: false,
      );
}

class BodyHome extends StatelessWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Text("register page")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfirmPage()));
                },
                child: Text("confirm page")),
          ],
        ),
      ),
    );
  }
}
