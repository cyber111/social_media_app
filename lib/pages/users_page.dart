import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/back_button.dart';
import 'package:social_media_app/helper/helper_functions.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            displayErrorMessage('Something went wrong', context);
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('No Data'),
            );
          }
          //get users and display
          final users = snapshot.data!.docs;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user['userName']),
                      subtitle: Text(user['email']),
                    );
                  },
                  itemCount: users.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
