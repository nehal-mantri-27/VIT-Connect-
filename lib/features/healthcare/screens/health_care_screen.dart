import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vit_connect_plus/common/widgets/rounded_image.dart';
import 'package:vit_connect_plus/features/healthcare/screens/medicine_screen.dart';
import 'package:vit_connect_plus/features/healthcare/widgets/header.dart';
import 'package:vit_connect_plus/features/lost_and_found/screens/lost_and_found_screen.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';
import 'package:vit_connect_plus/utils/constants/sizes.dart';
import 'package:vit_connect_plus/utils/helpers/helper_functions.dart';
import 'package:vit_connect_plus/features/healthcare/controllers/appointment_controller.dart';

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
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              DoctorInfoCard(),
              SizedBox(height: 16),
              DoctorInfoCard(
                backgroundColor: MyColors.primary.withOpacity(0.85),
                buttonColor: MyColors.primary.withOpacity(0.95),
              ),
              SizedBox(height: 16),
              DoctorInfoCard(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorInfoCard extends StatelessWidget {
  DoctorInfoCard({
    Key? key,
    this.name = "John Doe",
    this.qualification = "MBBS|MD (Physician)",
    this.location = "HealthCdentre, Ground Floor",
    Color? backgroundColor,
    Color? buttonColor,
  })  : backgroundColor = backgroundColor ?? MyColors.primary.withOpacity(0.7),
        buttonColor = buttonColor ?? MyColors.primary.withOpacity(0.4),
        super(key: key);
  final appointmentController = Get.put(AppointmentController());

  final String name;
  final String qualification;
  final String location;
  final Color backgroundColor;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 190,
      width: double.infinity,
      backgroundColor: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/found-1.jpeg"),
            ),
            SizedBox(width: 16),
            Expanded(
              // Wrap the Text widget with Expanded
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                          color: MyColors.light,
                          fontSizeDelta: 2,
                        ),
                  ),
                  Text(
                    qualification,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: MyColors.light,
                          fontSizeDelta: 0.5,
                        ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    location, // Removed Expanded widget here
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: MyColors.light,
                          fontSizeDelta: 0.5,
                        ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          buttonColor, // Background color
                        ),
                      ),
                      onPressed: () {
                        appointmentController.goToBookAppointment();
                      },
                      child: Text(
                        "Check Availability",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
