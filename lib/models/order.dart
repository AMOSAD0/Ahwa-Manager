import 'package:task_1/models/drink.dart';

class Order {
  final String id;
  final String customerName;
  final Drink drink;
  bool _completed;

  Order({
    required this.id,
    required this.customerName,
    required this.drink,
    bool completed = false,
  }) : _completed = completed;

  bool get completed => _completed;
  void markComplete() => _completed = true;
}


/*
Encapsulation: In the `Order` class, the `_completed` field is private 
and can only be modified through `markComplete()`. This ensures controlled 
state management and prevents unintended changes.
*/