import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
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
      body: ref
          .watch(feedProvider)
          .when(
            data: (List<Tweet> tweets) {
              return ListView.builder(
                itemCount: tweets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(tweets[index].profilePic),
                    ),
                    title: Text(
                      tweets[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      tweets[index].tweet,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  );
                },
              );
            },
            error: (error, StackTrace) {
              return Text("error");
            },
            loading: () => CircularProgressIndicator(),
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
