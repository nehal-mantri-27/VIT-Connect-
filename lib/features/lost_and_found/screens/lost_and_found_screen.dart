import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vit_connect_plus/common/widgets/appbar.dart';
import 'package:vit_connect_plus/features/lost_and_found/widgets/found_card_vertical.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';

class LostAndFoundScreen extends StatelessWidget {
  const LostAndFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: MyColors.primary,
          ),
          appBar: AppBar(
            title: LFAppBar(),
            bottom: TabBar(labelStyle: TextStyle(fontSize: 12), tabs: [
              Tab(
                icon: Icon(
                  Iconsax.blend,
                  color: MyColors.primary,
                  size: 24,
                ),
                text: "Found",
              ),
              Tab(
                  icon: Icon(
                    Iconsax.box_search,
                    color: MyColors.primary,
                    size: 24,
                  ),
                  text: "Lost")
            ]),
          ),
          body: TabBarView(
            children: [FoundScreen(), LostScreen()],
          )),
    );
  }
}

class LostScreen extends StatelessWidget {
  const LostScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Text("lost")],
      ),
    );
  }
}

class FoundScreen extends StatelessWidget {
  const FoundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Text("Found"), FoundCardVertical()],
      ),
    );
  }
}

class LFAppBar extends StatelessWidget {
  const LFAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lost And Found"),
          SizedBox(
            height: 6,
          ),
          Text("Lost Something? We've got you.",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: const Color.fromRGBO(158, 158, 158, 1))),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
