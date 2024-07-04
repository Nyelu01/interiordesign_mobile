import 'package:flutter/material.dart';
import 'package:interiordesign_mobile/Components/project_card.dart';
import 'package:interiordesign_mobile/Components/project_list_appbar.dart';
import 'package:interiordesign_mobile/Model/project_model.dart';
import 'package:interiordesign_mobile/screens/budget_page.dart';
import 'package:interiordesign_mobile/widgets/home_search_bar.dart';

class ProjectList extends StatefulWidget {
  final List<ProjectItem> projects;

  const ProjectList({Key? key, required this.projects}) : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  int _selectedIndex = 1;
  String _searchQuery = '';

  void _onItemTapped(int index) {
    if (index == 0 || index == 2) {
      // Navigate to respective pages
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BudgetPage()),
        );
      } else {
        Navigator.pop(context);
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  List<ProjectItem> getFilteredProjects() {
    if (_searchQuery.isEmpty) {
      return widget.projects;
    } else {
      return widget.projects
          .where((project) =>
              project.projectName.toLowerCase().contains(_searchQuery) ||
              project.description.toLowerCase().contains(_searchQuery))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProjectItem> filteredProjects = getFilteredProjects();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProjectListAppbar(),
                const SizedBox(height: 5),
                HomeSearchBar(
                  onChanged: _onSearchChanged,
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    ProjectItem projectItem = filteredProjects[index];
                    return ProjectCard(
                      project: projectItem,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Budgets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow.shade700,
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        onTap: _onItemTapped,
      ),
    );
  }
}
