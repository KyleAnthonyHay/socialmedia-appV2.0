import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:socialmediaapv2/components/MyListTile.dart';
import 'package:socialmediaapv2/helper/HelperFunctions.dart';

import '../components/MyBackButton.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            // any errors
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }
            // show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return const Text("No Data");
            }
            // get all users
            final users = snapshot.data!.docs;

            return Column(
              children: [
                // back button
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // List of Users on the app
                Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        // get individual user
                        final user = users[index];
                        // get data from each user
                        String username = user['username'];
                        String email = user['email'];

                        return MyListTile(title: username, subTitle: email);
                      }),
                ),
              ],
            );
          }),
    );
  }
}
