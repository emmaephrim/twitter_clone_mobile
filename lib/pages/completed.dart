import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:twitter_clone/models/todo.dart';
import 'package:twitter_clone/providers/todo_provider.dart';

class CompletedTodo extends ConsumerWidget {
  const CompletedTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> completedTodos = ref
        .watch(todoListProvider)
        .where((todo) => todo.completed == true)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Completed Todos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: completedTodos.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => ref
                      .watch(todoListProvider.notifier)
                      .deleteTodo(completedTodos[index]),
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: ListTile(title: Text(completedTodos[index].content)),
            ),
          );
        },
      ),
    );
  }
}
