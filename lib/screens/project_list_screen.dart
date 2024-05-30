import 'package:flutter/material.dart';
import 'package:interiordesign_mobile/Components/Project.dart';
import 'package:interiordesign_mobile/Components/project_card.dart';
import 'package:interiordesign_mobile/Components/project_list_appbar.dart';
import 'package:interiordesign_mobile/widgets/home_search_bar.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProjectListAppbar(),
                SizedBox(
                  height: 5,
                ),
                const HomeSearchBar(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 10), // Add padding here
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) => ProjectCard(
                      project: projects[index],
                    ),
                    itemCount: projects.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
