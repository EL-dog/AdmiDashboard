import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_management/features/dash_board/widgets/attendance.dart';
import 'package:school_management/features/dash_board/widgets/result.dart';
import 'package:school_management/features/dash_board/widgets/student_info_card.dart';
import 'package:school_management/features/dash_board/widgets/student_list.dart';

final selectedStudentProvider = StateProvider<Map<String, String>?>(
  (ref) => null,
);

class Students extends ConsumerStatefulWidget {
  const Students({super.key});

  @override
  _Students createState() => _Students();
}

final List<Map<String, String>> _students = [
  {
    "name": "Sahil",
    "id": "sdadsadas",
    "year": "2020",
    "class": "12",
    "Section": "A",
    "Gender": "Male",
    "Mobile": "+91799215677",
    "Email": "ddsfsdfgres@dfsd.com",
    "Dob": "12/10/2009",
    "Address": "da lcdfd dfe  230231",
  },
  {
    "name": "Rishabh",
    "id": "dsdwwdwf",
    "year": "2021",
    "class": "10",
    "Section": "C",
    "Gender": "Male",
    "Mobile": "+917992355677",
    "Email": "ddsftsdfs@dfsd.com",
    "Dob": "12/10/2009",
    "Address": "da lcdfd dfe  230231",
  },
  {
    "name": "Daksh",
    "id": "dsfdsfdsfd",
    "year": "2019",
    "class": "11",
    "Section": "D",
    "Gender": "Trans",
    "Mobile": "+91799253277",
    "Email": "ddsfsdwretws@dfsd.com",
    "Dob": "12/09/2008",
    "Address": "da lcdfd dfe  230231",
  },
  {
    "name": "Ayush",
    "id": "ddafdfs",
    "year": "2022",
    "class": "2",
    "Section": "B",
    "Gender": "Male",
    "Mobile": "+9179923226537",
    "Email": "ddsf@dfsd.com",
    "Dob": "12/10/2009",
    "Address": "da lcdfd dfe  230231",
  },
  {
    "name": "Abhishek",
    "id": "adfdsaff",
    "year": "2023",
    "class": "1",
    "Section": "A",
    "Gender": "Female",
    "Mobile": "+917674215677",
    "Email": "dwretetdsfsdfs@dfsd.com",
    "Dob": "12/10/2009",
    "Address": "da lcdfd dfe  230231",
  },
];

class _Students extends ConsumerState<Students> {
  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 1000, maxWidth: 1600),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student Data",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            itemCount: _students.length,
                            separatorBuilder: (_, __) => Divider(),
                            itemBuilder: (context, index) {
                              final student = _students[index];
                              return StudentList(
                                name: student['name']!,
                                studentId: student['id']!,
                                year: student['year']!,
                                clas: student['class']!,
                                onTap: () {
                                  ref
                                      .read(selectedStudentProvider.notifier)
                                      .state = student;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10),

              Expanded(flex: 1, child: StudentInfo()),

              SizedBox(width: 10),

              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(child: Attendance()),
                    SizedBox(height: 10),
                    Expanded(child: Result()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
