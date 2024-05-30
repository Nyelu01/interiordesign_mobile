import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:interiordesign_mobile/Components/Project.dart';
import 'package:interiordesign_mobile/screens/project_description.dart';
import 'package:interiordesign_mobile/screens/project_list_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectList(),
                ),
              ),
              child: const Text("View all"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              projects.length,
              (index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProjectImages(project: projects[index]),
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
                                image: AssetImage(projects[index].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            projects[index].service_type,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.user,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "By: ${projects[index].designer}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Icon(
                                Iconsax.location,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${projects[index].location}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
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
                                "${projects[index].grade}/5",
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
                      //     icon: const Icon(Iconsax.heart),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
