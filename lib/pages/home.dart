import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import 'package:twitter_clone/providers/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: Colors.grey, height: 1),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        title: FaIcon(FontAwesomeIcons.twitter, size: 45, color: Colors.blue),
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
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey.shade500),
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
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                currentUser.user.profilePic,
                fit: BoxFit.fitWidth,
              ),
            ),
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
