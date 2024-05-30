import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:interiordesign_mobile/Components/Project.dart';
import 'package:interiordesign_mobile/screens/project_description.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectImages(project: project),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(project.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.service_type,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.user,
                            size: 18,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Text(
                              "By: ${project.designer}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Iconsax.location,
                            size: 18,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Text(
                              "${project.location} ",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Iconsax.star5,
                              color: Colors.yellow.shade700, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            "${project.grade}/5",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // Positioned(
                  //   top: 1,
                  //   right: 1,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     style: IconButton.styleFrom(
                  //       backgroundColor: Colors.white,
                  //       fixedSize: const Size(30, 30),
                  //     ),
                  //     iconSize: 20,
                  //     icon: project.isLiked
                  //         ? const Icon(
                  //             Iconsax.heart5,
                  //             color: Colors.red,
                  //           )
                  //         : const Icon(Iconsax.heart),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
