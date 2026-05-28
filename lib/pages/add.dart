import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  AddTodo({super.key});

  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Todo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: todoController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .watch(todoListProvider.notifier)
                    .addTodo(todoController.text);
                Navigator.pop(context);
              },
              child: Text("Add Todo", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
