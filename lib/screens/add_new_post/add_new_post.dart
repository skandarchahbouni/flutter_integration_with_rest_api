import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_response.dart';
import 'package:flutter_api/screens/components/error_dialog.dart';
import 'package:flutter_api/screens/components/success_dialog.dart';
import 'package:flutter_api/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';


final GetIt getIt = GetIt.instance;

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void _addNewPost() async {
    setState(() {
      isLoading = true;
    });
    try {
      // PostService service = PostService();
      PostService service = getIt<PostService>();
      try {
        APIResponse response = await service.addnewPost(
            title: titleController.text, body: bodyController.text);
        if (response.data == true) {
          // show success dialog
          // go to the home page
          showSuccessDialog(context,
              title: "Thank you!",
              body: "Your post had been created Succesfully!");
          setState(() {
            isLoading = false;
          });
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        } else {
          showErrorDialog(context,
              title: "Something went wrong, please try again later.",
              body: "Sorry!");
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showErrorDialog(context,
            title: "Something went wrong, please try again later.",
            body: "Sorry!");
        // show Something to the user
      }
    } catch (e) {
      // show Something to the user
    }
  }

  void _addItemToCart(CartProvider provider){
    provider.update();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new post"),
        leading: CircleAvatar(child: Text("${provider.nbitems}"), backgroundColor: Colors.red,),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Builder(builder: (context) {
          // if (isLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: "Title", labelText: "Title"),
                  maxLines: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    hintText: "Body",
                    labelText: "Body",
                  ),
                  maxLines: null,
                ),
                ElevatedButton(
                  // disable the button until the request is handeled
                    onPressed: isLoading ? null : _addNewPost, child: isLoading ? const FittedBox(child: Center(child: CircularProgressIndicator(),)):const Text("Add new post")),
                ElevatedButton(onPressed: ()=> _addItemToCart(provider), child: const Text("Add item to cart"))
              ],
            ),
          );
        }),
      )),
    );
  }
}
