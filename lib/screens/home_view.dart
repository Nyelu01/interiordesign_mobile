import 'package:flutter/material.dart';
import 'package:interiordesign_mobile/Model/project_model.dart';
import 'package:interiordesign_mobile/api.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/requests/getproject_request.dart';
import 'package:interiordesign_mobile/screens/project_description.dart';
import 'package:interiordesign_mobile/screens/project_list_screen.dart';
import 'package:interiordesign_mobile/widgets/widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool projectavailable = false;
  List<ProjectItem> projdata = [];

  @override
  void initState() {
    super.initState();
    getallproject();
  }

  Future<void> getallproject() async {
    try {
      ApiResponse response = await Getallproject.getallproject(context);

      if (response.error == null) {
        successToast('Data available');
        setState(() {
          projdata = (response.data as ProjectModel).projects;
          projdata.forEach((project) {
            print('the available data are ${project.projectName}');
          });
          projectavailable = true;
        });
      } else {
        print('Error: ${response.error}');
        errorToast('Data not available');
      }
    } catch (e) {
      print('Error occurred in getting projects data: $e');
    }
  }

  Future<void> _refreshProjects() async {
    await getallproject();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProjects,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent posted",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectList(projects: projdata),
                    ),
                  );
                },
                child: const Text("View all"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 10), // Add padding to remove overflow
              child: Row(
                children: projdata.map((project) {
                  final imageUrl = project.attachments.isNotEmpty
                      ? '${serverUrlPlain}storage/${project.attachments[0].url}'
                      : 'default_image_path';

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectImages(project: project),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 200,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                project.projectName ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "By: ${project.user!.name}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    // Added Expanded to make sure it does not overflow
                                    child: Text(
                                      "${project.projectLocation}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.yellow.shade700, size: 20),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${project.projectGrade}/5",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
