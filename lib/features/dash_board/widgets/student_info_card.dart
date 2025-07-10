import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_management/features/dash_board/screens/student.dart';

class StudentInfo extends ConsumerWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(selectedStudentProvider);

    if (student == null) {
      return Center(
        child: Text(
          "Select a student to view details",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return Card(
      elevation: 10,
      shadowColor: Colors.blueGrey,

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/avatar_placeholder.png',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    student['name'] ?? 'Unknown',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("ID: ${student['id']}"),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Divider(),
            const SizedBox(height: 8),

            Text(
              "Basic Details",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildInfoRow("Class", student['class']),
            _buildInfoRow("Section", student['Section']),
            _buildInfoRow("Gender", student['Gender']),
            _buildInfoRow("Mobile", student['Mobile']),
            _buildInfoRow("Email", student['Email']),
            _buildInfoRow("Date of Birth", student['Dob']),
            _buildInfoRow("Address", student['Address']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value ?? '-', overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
