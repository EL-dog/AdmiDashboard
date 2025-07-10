import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_management/features/dash_board/screens/student.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class DashboardShell extends ConsumerWidget {
  const DashboardShell({super.key});

  static final _pages = <Widget>[
    Center(child: Text(' Dashboard Home')),
    Center(child: Text(' Teachers')),
    Center(child: Padding(padding: EdgeInsets.all(20), child: Students())),
    Center(child: Text(' Calendar')),
    Center(child: Text(' Settings')),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("School Admin Panel"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 3,
            selectedIndex: selectedIndex,
            onDestinationSelected:
                (index) =>
                    ref.read(selectedIndexProvider.notifier).state = index,
            labelType: NavigationRailLabelType.all,

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text("Dashboard"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text("Teachers"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group),
                label: Text("Students"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text("Calendar"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
              ),
            ],
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
