import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/back_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance.collection('Users').doc(currentUser!.email).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error
          else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          //data
          else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return userProfile(user!['email'], user['userName']);
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }

  Widget userProfile(String email, String username) {
    return Center(
      child: Column(
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
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.secondary),
            child: const Icon(
              Icons.person,
              size: 100,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            email,
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
