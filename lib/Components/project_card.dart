import 'package:flutter/material.dart';
import 'package:interiordesign_mobile/Model/project_model.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/screens/project_description.dart';

class ProjectCard extends StatelessWidget {
  final ProjectItem project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = project.attachments.isNotEmpty
        ? '${serverUrlPlain}storage/${project.attachments[0].url}'
        : 'default_image_path';

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectImages(project: project),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project.serviceType,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "By: ${project.user!.name}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      "${project.projectGrade}/5",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Add space to avoid overflow
              ],
            ),
          ),
        ),
      ),
    );
  }
}
