import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';

class CreateTweet extends ConsumerWidget {
  const CreateTweet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _tweetController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Post a tweet")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _tweetController,
              maxLines: 4,
              maxLength: 300,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(tweetProvider).postTweet(_tweetController.text);
              Navigator.pop(context);
            },
            child: Text("Post tweet"),
          ),
        ],
      ),
    );
  }
}
