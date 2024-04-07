import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vit_connect_plus/common/widgets/appbar.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [HomeAppBar()],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome Back,",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: const Color.fromRGBO(158, 158, 158, 1))),
          SizedBox(
            height: 4,
          ),
          Text("Juhi Mantri",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: MyColors.darkerGrey))
        ],
      ),
      actions: [
        GestureDetector(onTap: () {}, child: const Icon(Iconsax.menu))
        //now since we want to show the shopping bag with the count, we use two widgets, stacked one on top of the other,
        //for the count we use a simple circular container
      ],
    );
  }
}
