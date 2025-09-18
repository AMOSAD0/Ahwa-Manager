import 'package:flutter/material.dart';
import 'package:task_1/models/drink.dart';
import 'package:task_1/views/state/manager.dart';

class OrdersPage extends StatefulWidget {
  final OrderManager orderManager;
  const OrdersPage({required this.orderManager, Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final pending = widget.orderManager.pendingOrders;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pending Orders',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: pending.isEmpty
                ? const Center(child: Text('No pending orders'))
                : ListView.builder(
                    itemCount: pending.length,
                    itemBuilder: (ctx, i) {
                      final o = pending[i];
                      return Card(
                        child: ListTile(
                          title: Text(
                            '${o.drink.displayName} for ${o.customerName}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () {
                              widget.orderManager.completeOrder(o.id);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _showAddDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Order'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog() {
    final nameCtrl = TextEditingController();
    String? selectedDrinkType;
    String teaVariant = "Regular";

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text("Add Order"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Customer Name"),
              ),
              DropdownButtonFormField<String>(
                value: selectedDrinkType,
                items: const [
                  DropdownMenuItem(value: "tea", child: Text("Shai")),
                  DropdownMenuItem(
                    value: "coffee",
                    child: Text("Turkish Coffee"),
                  ),
                ],
                onChanged: (val) {
                  setDialogState(() {
                    selectedDrinkType = val;
                  });
                },
                decoration: const InputDecoration(labelText: "Drink"),
              ),
              if (selectedDrinkType == "tea") ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: teaVariant,
                  items: const [
                    DropdownMenuItem(value: "Regular", child: Text("Regular")),
                    DropdownMenuItem(value: "Mint", child: Text("Mint")),
                  ],
                  onChanged: (val) {
                    setDialogState(() {
                      teaVariant = val ?? "Regular";
                    });
                  },
                  decoration: const InputDecoration(labelText: "Tea Variant"),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && selectedDrinkType != null) {
                  late Drink drinkToAdd;

                  if (selectedDrinkType == "tea") {
                    drinkToAdd = Tea(variant: teaVariant);
                  } else {
                    drinkToAdd = TurkishCoffee();
                  }

                  widget.orderManager.addOrder(
                    customerName: nameCtrl.text,
                    drink: drinkToAdd,
                  );

                  setState(() {});
                  Navigator.pop(ctx);
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
