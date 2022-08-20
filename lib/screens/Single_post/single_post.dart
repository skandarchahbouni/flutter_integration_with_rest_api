import 'package:flutter/material.dart';
import 'package:flutter_api/models/post.dart';
import 'package:flutter_api/screens/components/error_dialog.dart';
import 'package:flutter_api/screens/components/success_dialog.dart';
import 'package:flutter_api/screens/providers/cart_provider.dart';
import 'package:flutter_api/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../components/dialog.dart';

final GetIt getIt = GetIt.instance;

class SinglePost extends StatefulWidget {
  final Post post;
  const SinglePost({ Key? key, required this.post }) : super(key: key);

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool _isloading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void _updatePost ()async{
    Navigator.pop(context);
    // PostService service = PostService();
    PostService service = getIt<PostService>();
      setState(() {
        _isloading = true;
      });
    try {
      var response = await service.updatePost(updatedPost: Post(id: widget.post.id, userId: widget.post.userId, title: titleController.text, body: bodyController.text ));
      setState(() {
        _isloading = false;
      });
      if(response.data == true){
        showSuccessDialog(context, title: "Thank you!", body :"Your post had been updated succesfully!");
      }else{
        showErrorDialog(context, title: "Sorry!", body :"Something went wrong");
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      showErrorDialog(context, title: "Sorry!", body :"Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post.title;
    bodyController.text = widget.post.body ?? "";
  }
  @override
  Widget build(BuildContext context) {
    CartProvider provider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
        leading:  CircleAvatar(child: Text("${provider.nbitems}"), backgroundColor: Colors.red,),
      ),
      body: SafeArea(child: Builder(
        builder: (context) {
          if(_isloading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children:  [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    labelText: "Title"
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    hintText: "Body",
                    labelText: "Body",
                  ),
                  maxLines: null,
                ),
              ],
            ),
          );
        }
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.update),
        onPressed: (){
          // show the dialog 
          showAlertDialog(context,  handleConfirm: _updatePost, title: "Update the post", body: "Please confirm that you wanna update the post by clicking in the button bellow.");
        },
      ),
    );
  }
}
