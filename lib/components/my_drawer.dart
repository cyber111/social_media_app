
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/helper/helper_functions.dart';
import 'package:social_media_app/pages/profile_page.dart';
import 'package:social_media_app/pages/users_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
   void logout() async {
     await FirebaseAuth.instance.signOut();
   }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //Header
              const DrawerHeader(child: Icon(Icons.people, size: 100,)),
              //Home
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('W A L L'),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              //Profile
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('P R O F I L E'),
                  onTap: () {
                    goToPage(context, const ProfilePage());
                  },
                ),
              ),
              //Users
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('U S E R S'),
                  onTap: () {
                    goToPage(context, const UsersPage());
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T'),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
