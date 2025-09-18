import 'package:task_1/models/order.dart';
import 'package:task_1/repo/orderRepository.dart';

class DataOrder implements IOrderRepository {
  final List<Order> _orders = [];

  @override
  void addOrder(Order order) {
    _orders.add(order);
  }

  @override
  void completeOrder(String id) {
    final o = _orders.firstWhere((e) => e.id == id);
    o.markComplete();
  }

  @override
  List<Order> fetchAllOrders() {
    return List.unmodifiable(_orders);
  }
}
