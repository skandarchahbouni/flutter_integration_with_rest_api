import 'package:flutter/material.dart';
import 'package:flutter_api/screens/home/home.dart';
import 'package:flutter_api/screens/providers/cart_provider.dart';
import 'package:flutter_api/screens/providers/user_provider.dart';
import 'package:flutter_api/screens/wrapper.dart';
import 'package:flutter_api/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


void setup() {
// Alternatively you could write it if you don't like global variables
  GetIt.I.registerLazySingleton<PostService>((() => PostService()));
}
void main() {
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
    child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:  const Wrapper(),
    );
  }
}
