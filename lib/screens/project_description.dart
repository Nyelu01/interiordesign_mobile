import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:interiordesign_mobile/Model/project_model.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/screens/submit_requirement.dart';

class ProjectImages extends StatefulWidget {
  final ProjectItem project;
  const ProjectImages({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectImages> createState() => _ProjectImagesState();
}

class _ProjectImagesState extends State<ProjectImages> {
  late List<Widget> carouselItems;

  @override
  void initState() {
    super.initState();
    carouselItems = widget.project.attachments
        .map((attachment) => Image.network(
              '${serverUrlPlain}storage/${attachment.url}',
              fit: BoxFit.cover,
            ))
        .toList();

    // Debugging output
    print('Generated carousel items: $carouselItems');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: Colors.grey[300], // Your desired background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height: size.height * 0.2,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {},
              ),
            ),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.projectName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey,
                      ),
                      // Text(
                      //   "By: ${widget.project.user?.name ?? ''}",
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.project.projectLocation,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade700,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${widget.project.projectGrade}/5',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Project name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.project.projectName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Text(
                        "Budget",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.project.totalBudget,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.project.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SubmitRequirement(
                                  projectId: widget.project.id),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 140, 143, 146),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Send direct inquiry"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
