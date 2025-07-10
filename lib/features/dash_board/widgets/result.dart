import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Result extends ConsumerStatefulWidget {
  const Result({super.key});

  @override
  _Result createState() => _Result();
}

class _Result extends ConsumerState<Result> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Result Sheet",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: Text("Math"),
                    title: Text("95/100"),
                    trailing: Text("Grade Remark"),
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
