import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

class ProjectListAppbar extends StatelessWidget {
  const ProjectListAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[300],
            fixedSize: const Size(55, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          color: Colors.black,
          icon: const Icon(CupertinoIcons.chevron_back),
        ),
        const Spacer(),
        const Text(
          "Project list",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
