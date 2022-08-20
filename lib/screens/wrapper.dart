import 'package:flutter/material.dart';
import 'package:flutter_api/screens/home/home.dart';
import 'package:flutter_api/screens/login/login.dart';
import 'package:flutter_api/screens/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}


class _WrapperState extends State<Wrapper> {

  String? _token;
  void _getSharedPrefs() async{
    try {
      final prefs = await SharedPreferences.getInstance(); 
      setState(() {
        _token = prefs.getString("Token");
      });
    } catch (e) {
      //TODO 2 : Show Something to the user
    }
  }

  Future<bool> _redirect() async{
      final prefs = await SharedPreferences.getInstance(); 
      String? token = prefs.getString("Token");
      if(token != null){
        return true;
      }else{
        return false;
      }
  }


  // @override
  // void initState() {
  //   //TODO 1 : implement initState
  //   super.initState();
  //   _getSharedPrefs();
  // }
  @override
  Widget build(BuildContext context) {
    // return Builder(builder: (BuildContext context) {
    //   if(_token != null){
    //     // here is where the read is usefull 
    //     CartProvider provider = context.read<CartProvider>();
    //     provider.initialize(14);
    //     return const HomePage();
    //   } else{
    //     return const Login();
    //   }
    // },
    // );
    return FutureBuilder<bool>(
      future: _redirect(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if (snapshot.hasError){
          return const Scaffold(body: Text("error"));
        }
        if (snapshot.hasData){
          // return Scaffold(body: Scaffold(body: Center(child: Text("${snapshot.data}"),)),);
          if(snapshot.data == true){
            CartProvider provider = context.read<CartProvider>();
            provider.initialize(14);
            return const HomePage();
          }else{
            return const Login();
          }
        }
        return const Scaffold();
      }
    );
  }
}