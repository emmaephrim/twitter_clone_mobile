import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:twitter_clone/models/todo.dart';
import 'package:twitter_clone/pages/add.dart';
import 'package:twitter_clone/pages/completed.dart';
import 'package:twitter_clone/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> completedTodos = ref
        .watch(todoListProvider)
        .where((todo) => todo.completed == true)
        .toList();

    List<Todo> activeTodos = ref
        .watch(todoListProvider)
        .where((todo) => todo.completed != true)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: activeTodos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => ref
                            .watch(todoListProvider.notifier)
                            .deleteTodo(activeTodos[index]),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => ref
                            .watch(todoListProvider.notifier)
                            .completeTodo(activeTodos[index].todoId),
                        icon: Icons.check,
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),
                  child: ListTile(title: Text(activeTodos[index].content)),
                );
              },
            ),
          ),
          completedTodos.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CompletedTodo()),
                    );
                  },
                  child: Text("Completed Todo"),
                )
              : Container(),
        ],
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
