import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vit_connect_plus/common/widgets/form_divider.dart';
import 'package:vit_connect_plus/features/healthcare/screens/medicine_screen.dart';
import 'package:vit_connect_plus/features/healthcare/widgets/header.dart';
import 'package:vit_connect_plus/features/lost_and_found/screens/lost_and_found_screen.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';
import 'package:vit_connect_plus/utils/constants/sizes.dart';
import 'package:vit_connect_plus/utils/helpers/helper_functions.dart';

class HealthCareScreen extends StatelessWidget {
  const HealthCareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 3, // Define the number of tabs
      child: Scaffold(
        body: Column(
          children: [
            HeaderAndTabs(dark: dark),
            Expanded(
              child: TabBarView(
                children: [
                  // Sample text for Doctors tab
                  DoctorScreen(),
                  // Sample text for Medicines tab
                  MedicineScreen(),
                  // Sample text for History tab
                  HistoryScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
