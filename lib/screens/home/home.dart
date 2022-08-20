
import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_response.dart';
import 'package:flutter_api/screens/Single_post/single_post.dart';
import 'package:flutter_api/screens/add_new_post/add_new_post.dart';
import 'package:flutter_api/screens/components/dialog.dart';
import 'package:flutter_api/screens/components/error_dialog.dart';
import 'package:flutter_api/screens/components/success_dialog.dart';
import 'package:flutter_api/screens/providers/cart_provider.dart';
import 'package:flutter_api/services/post_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../wrapper.dart';

final GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = <Post>[];
  bool _isFetching = false;

  void _getposts() async {
    // use the locator and why
    setState(() {
      _isFetching = true;
    });
    // PostService service = PostService();
    PostService service = getIt<PostService>();
    try {
      APIResponse response = await service.getAllposts();
      posts = response.data;
      setState(() {
        _isFetching = false;
      });
    } catch (e) {
      // show Something to the user
      setState(() {
        _isFetching = false;
      });
    }
  }

  void _deletePost(int postId) async {
    Navigator.pop(context);
    setState(() {
      _isFetching = true;
    });
    // PostService service = PostService();
    PostService service = getIt<PostService>();
    try {
      APIResponse response = await service.deletePost(postId: postId);
      setState(() {
        _isFetching = false;
      });
      if (response.data = true) {
        showSuccessDialog(context,
            title: "Success!!", body: "Your post had been deleted succesfully");
      } else {
        showErrorDialog(context,
            title: "Sorry!", body: "Something went wrong!");
      }
    } catch (e) {
      setState(() {
        _isFetching = false;
      });
      showErrorDialog(context, title: "Sorry!", body: "Something went wrong!");
    }
  }

  void _logout()async{
    try {
      setState(() {
        _isFetching = true;
      });
      final prefs = await SharedPreferences.getInstance(); 
      await prefs.remove("Token");
      setState(() {
        _isFetching = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Wrapper()));
    } catch (e) {
      // Show something to the user
    }
  }

  @override
  void initState() {
    _getposts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("posts"),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
        ],
        leading: CircleAvatar(child: Text("${provider.nbitems}"), backgroundColor: Colors.red,),

      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNewPost()));
          }),
      body: SafeArea(
        child: Builder(builder: (context) {
          if (_isFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => InkWell(
              child: ListTile(
                title: Text(posts[index].title.substring(0, 4) + '...'),
                leading: CircleAvatar(
                  child: Text("${posts[index].id}"),
                  backgroundColor: Colors.green,
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Show the alert dialog
                    showAlertDialog(context,
                        handleConfirm: () => _deletePost(posts[index].id),
                        title: "Delete Post",
                        body: "Confirm deleting the post.");
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SinglePost(post: posts[index])),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
