class Todo {
  int todoId;
  String content;
  bool completed;

  Todo({required this.todoId, required this.content, required this.completed});

  Todo copyWith({int? todoId, String? content, bool? completed}) {
    return Todo(
      todoId: todoId ?? this.todoId,
      content: content ?? this.content,
      completed: completed ?? this.completed,
    );
  }
}
