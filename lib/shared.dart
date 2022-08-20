import 'package:flutter/material.dart';
import 'package:flutter_api/screens/components/success_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared extends StatefulWidget {
  const Shared({ Key? key }) : super(key: key);

  @override
  State<Shared> createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  void _save() async{
    try {
      final prefs = await SharedPreferences.getInstance(); 
      await prefs.setString("fist-name", "Skandar Ramzi");
      await prefs.setString("last-name", "Chahbouni");
      await prefs.setString("Token", "qdkzjadlazdpoazidaz");
    } catch (e) {
      // Show something to the user
    }
  }

  void _show()async{
    try {
      final prefs = await SharedPreferences.getInstance(); 
      String? firstName = prefs.getString("fist-name");
      showSuccessDialog(context, title: firstName, body: "body");

    } catch (e) {
      // Show something to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child:const Text("Save"),
              onPressed: _save,
            ),
            ElevatedButton(onPressed: _show, child: const Text("Show"))
          ],
        ),
      )),
    );
  }
}