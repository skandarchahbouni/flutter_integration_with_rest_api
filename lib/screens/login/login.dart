import 'package:flutter/material.dart';
import 'package:flutter_api/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  void _login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("Token", "qdkzjadlazdpoazidaz");
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Wrapper()));
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show something to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login page"),
        backgroundColor: Colors.orange,
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _login, child: const Text("Login"))
              ],
            ),
          ));
        }
      }),
    );
  }
}
