import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/pages/create_tweet.dart';
import 'package:twitter_clone/pages/home.dart';
import 'package:twitter_clone/pages/login.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/pages/signup.dart';
import 'package:twitter_clone/providers/user_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400),
        appBarTheme: AppBarTheme(
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.5),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue.shade400,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const HomePage();
      //     }
      //     return const SignUp();
      //   },
      // ),
      routes: {
        '/': (context) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ref.read(userProvider.notifier).login(snapshot.data!.email!);
                return const HomePage();
              }
              return const Login();
            },
          );
        },
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/settings': (context) => const SettingsPage(),
        '/createTweet': (context) => const CreateTweet(),
      },
    );
  }
}
