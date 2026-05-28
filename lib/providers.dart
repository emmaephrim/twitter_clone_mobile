import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Normal Provider
final normalProvider = Provider<String>((ref) {
  return "I'm just a normal string from a provider";
});

// Future Provider
final messageProvider = FutureProvider.autoDispose<String>((ref) async {
  return Future.delayed(Duration(seconds: 5), () {
    return "I'm a mesage from the the future";
  });
});

// StateNotiferProvider
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void add() {
    state = state + 2;
  }
}

final counterProvider = StateNotifierProvider.autoDispose<CounterNotifier, int>(
  (ref) {
    return CounterNotifier();
  },
);
