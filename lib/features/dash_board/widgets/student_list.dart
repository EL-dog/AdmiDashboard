import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  final String name;
  final String studentId;
  final String clas;
  final String year;
  final VoidCallback onTap;

  const StudentList({
    super.key,
    required this.name,
    required this.studentId,
    required this.year,
    required this.clas,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text("Class: $clas", style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Expanded(child: Text(studentId, overflow: TextOverflow.ellipsis)),
            Expanded(child: Text(year, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
