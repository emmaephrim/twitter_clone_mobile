import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/user_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);

    final TextEditingController _nameController = TextEditingController();
    _nameController.text = currentUser.user.name;
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(userProvider.notifier)
                    .updateName(_nameController.text);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
