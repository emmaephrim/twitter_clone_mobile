import 'package:flutter_riverpod/legacy.dart';
import 'package:twitter_clone/models/todo.dart';

final todoListProvider =
    StateNotifierProvider.autoDispose<TodoListNotifier, List<Todo>>((ref) {
      return TodoListNotifier();
    });

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String content) {
    state = [
      ...state,
      Todo(
        todoId: state.isEmpty ? 0 : state[state.length - 1].todoId + 1,
        content: content,
        completed: false,
      ),
    ];
  }

  void completeTodo(int id) {
    state = state
        .map(
          (todo) => todo.todoId == id ? todo.copyWith(completed: true) : todo,
        )
        .toList();
  }

  void deleteTodo(Todo todo) {
    state = state.where((t) => t.todoId != todo.todoId).toList();
  }
}
