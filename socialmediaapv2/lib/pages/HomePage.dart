import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapv2/components/MyDrawer.dart';
import 'package:socialmediaapv2/components/MyListTile.dart';
import 'package:socialmediaapv2/components/MyPostButton.dart';
import 'package:socialmediaapv2/components/MyTextField.dart';
import 'package:socialmediaapv2/database/firestore.dart';

class HomePage extends StatelessWidget {
  // Firestore Access
  final firestoreDatabase database = firestoreDatabase();
  // Text Controller
  TextEditingController newPostController = TextEditingController();

  HomePage({super.key});
  // post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("T H E  W A L L"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Text Field box for user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // textfield
                Expanded(
                  child: MyTextField(
                    hintText: "say somethong",
                    obscureText: false,
                    controller: newPostController,
                  ),
                ),
                // post button
                MyPostButton(
                  onTap: postMessage,
                )
              ],
            ),
          ),
          // POSTS
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // get all posts
              final posts = snapshot.data!.docs;
              // no data>
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text("No Posts..."),
                  ),
                );
              }
              // return as a list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get individual post
                    final post = posts[index];
                    // get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timeStamp = post['TimeStamp'];

                    // return as a list tile
                    return MyListTile(title: message, subTitle: userEmail);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
