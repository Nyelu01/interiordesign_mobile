import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:interiordesign_mobile/Components/Project.dart';
import 'package:interiordesign_mobile/config/colors.dart';
import 'package:interiordesign_mobile/widgets/project_images.dart';
import 'package:interiordesign_mobile/config/app_strings.dart';

class ProjectImages extends StatefulWidget {
  final Project project;
  const ProjectImages({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectImages> createState() => _ProjectImagesState();
}

class _ProjectImagesState extends State<ProjectImages> {
  late List<ImageContainer> carouselItems;

  @override
  void initState() {
    super.initState();
    carouselItems = [
      ImageContainer(imagePath: 'assets/project_images/p1.jpeg'),
      ImageContainer(imagePath: 'assets/project_images/p2.jpeg'),
      ImageContainer(imagePath: 'assets/project_images/p3.jpeg'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String serviceType = widget.project.service_type;
    String designer = widget.project.designer;
    String location = widget.project.location;
    String grade = "${widget.project.grade}/5";
    String projectName = widget.project.name;
    String budget = widget.project.budget;
    String description = widget.project.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.ptitle),
        backgroundColor: Colors.grey[300], // Your desired background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            SizedBox(height: 10), // Removed const
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceType,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10), // Removed const
                  Row(
                    children: [
                      const Icon(
                        Iconsax.user,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        "By: $designer",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Icon(
                        Iconsax.location,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Removed const
                  Row(
                    children: [
                      Icon(
                        Iconsax.star5,
                        color: Colors.yellow.shade700,
                        size: 25,
                      ),
                      SizedBox(width: 5), // Removed const
                      Text(
                        grade,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Removed const
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Removed const
                      Text(
                        projectName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "Budget",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Removed const
                      Text(
                        budget,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Removed const
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 20), // Added const
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Send direct inquiry"), // Removed const
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
