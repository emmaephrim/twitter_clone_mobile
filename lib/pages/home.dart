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
    List<Todo> todos = ref.watch(todoListProvider);

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
      body: todos.isNotEmpty
          ? Column(
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
                        child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: ListTile(
                            title: Text(activeTodos[index].content),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                completedTodos.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CompletedTodo(),
                            ),
                          );
                        },
                        child: Text("Completed Todo"),
                      )
                    : Container(),
              ],
            )
          : Center(
              child: Text(
                "Add a todo using the button below!",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
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
