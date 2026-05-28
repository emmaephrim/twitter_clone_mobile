import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/todo.dart';
import 'package:twitter_clone/pages/add.dart';
import 'package:twitter_clone/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: IconButton(
              onPressed: () {
                ref
                    .watch(todoListProvider.notifier)
                    .completeTodo(todos[index].todoId);
              },
              icon: const Icon(Icons.check, color: Colors.lightBlue),
            ),
            title: Text(
              todos[index].content,
              style: TextStyle(
                decoration: todos[index].completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                ref.watch(todoListProvider.notifier).deleteTodo(todos[index]);
              },
              icon: const Icon(Icons.delete, color: Colors.blueGrey),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
