import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_text_field2.dart';
import 'package:social_media_app/firebase/firestore.dart';
import 'package:social_media_app/helper/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //FireStore access
  FirestoreDatabase database = FirestoreDatabase();

  //TextController
  TextEditingController newPostTextController = TextEditingController();

  void postMessage() {
    //Check if controller is empty or not
    if (newPostTextController.text.isNotEmpty) {
      String message = newPostTextController.text;
      //Add post method in db
      database.addPost(message);
    }
    //cleat the controller
    newPostTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W A L L'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          //Text filed to add post
          StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              //loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                displayErrorMessage('Something went wrong', context);
              }

              //get all posts
              final posts = snapshot.data!.docs;

              //No Data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('No Posts, Post Something'),
                  ),
                );
              }
             
              return Expanded(child: ListView.builder(itemBuilder: (context, index) {
                //get a post
                final post = posts[index];
                //data from post
                String message = post['PostMessage'];
                String email = post['UserEmail'];
                // ignore: unused_local_variable
                Timestamp timeStamp = post['TimeStamp'];
                //return list tile
                return ListTile(title: Text(message), subtitle: Text(email),);
              }, itemCount: posts.length,));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: MyTextField2(
                        hintText: 'Say something ..',
                        textEditingController: newPostTextController,
                        obscureText: false)),
                IconButton(
                  onPressed: postMessage,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
