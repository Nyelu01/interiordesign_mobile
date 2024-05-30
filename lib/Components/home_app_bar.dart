import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: const Text(
            "What are you imagine?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
        // const Spacer(),
        // IconButton(
        //   onPressed: () {},
        //   style: IconButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //     backgroundColor: Colors.white,
        //     fixedSize: const Size(55, 55),
        //   ),
        //   icon: const Icon(Iconsax.notification),
        // ),
      ],
    );
  }
}
