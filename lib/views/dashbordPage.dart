import 'package:flutter/material.dart';
import 'package:task_1/views/state/manager.dart';

class DashboardPage extends StatefulWidget {
  final OrderManager orderManager;
  const DashboardPage({required this.orderManager, Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final report = widget.orderManager.generateReport();
    final topSelling = report['topSelling'] as Map<String, int>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sales Report",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text("Total Orders: ${report['totalOrders']}"),
            Text("Total Served: ${report['totalServed']}"),
            const SizedBox(height: 24),
            Text("Top Drinks:", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: topSelling.isEmpty
                  ? const Center(child: Text("No sales yet"))
                  : ListView.builder(
                      itemCount: topSelling.length,
                      itemBuilder: (ctx, i) {
                        final entry = topSelling.entries.elementAt(i);
                        return ListTile(
                          leading: CircleAvatar(child: Text('${i + 1}')),
                          title: Text(entry.key),
                          trailing: Text("x${entry.value}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
