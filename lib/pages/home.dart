import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(currentUser.user.profilePic),
                ),
              ),
            );
          },
        ),
        actions: [],
      ),
      body: Column(
        children: [Text(currentUser.user.email), Text(currentUser.user.name)],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Image.network(currentUser.user.profilePic),
            ListTile(
              title: Text(
                "Hello, ${currentUser.user.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),

            ListTile(
              title: Text(
                "Setttings",
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/settings");
              },
            ),

            ListTile(
              title: Text(
                "Sign Out",
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () {
                ref.watch(userProvider.notifier).logout();
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/createTweet");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
