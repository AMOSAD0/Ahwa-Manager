import 'package:task_1/models/order.dart';

abstract class IOrderRepository {
  void addOrder(Order order);
  void completeOrder(String id);
  List<Order> fetchAllOrders();
}

/*
Abstraction: `IOrderRepository` defines a contract for order repositories 
without exposing how orders are stored or managed. This makes it easy 
to switch implementations without changing the rest of the system.
*/
