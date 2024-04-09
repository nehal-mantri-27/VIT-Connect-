import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vit_connect_plus/common/widgets/form_divider.dart';
import 'package:vit_connect_plus/common/widgets/rounded_image.dart';
import 'package:vit_connect_plus/features/healthcare/widgets/appointment_header.dart';
import 'package:vit_connect_plus/features/healthcare/widgets/slot_card.dart';
import 'package:vit_connect_plus/features/healthcare/widgets/slot_grid_view.dart';
import 'package:vit_connect_plus/features/home/screens/home_screen.dart';
import 'package:vit_connect_plus/features/lost_and_found/screens/lost_and_found_screen.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';
import 'package:vit_connect_plus/utils/constants/sizes.dart';
import 'package:vit_connect_plus/utils/helpers/helper_functions.dart';

class DoctorAppointmentPage extends StatefulWidget {
  final String doctorName;

  DoctorAppointmentPage({required this.doctorName});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Book Appointment'),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderAndTabsAP(dark: dark),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a Date",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    OutlinedButton(
                        onPressed: () => _selectDate(context),
                        child: Icon(
                          Iconsax.calendar,
                          color: MyColors.darkerGrey,
                        )),
                    SizedBox(
                      height: Sizes.spacebtwitems,
                    ),
                    Text(
                      "Select a Preferred time slot",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SlotGridView(
                      itemCount: 5,
                      itemBuilder: (_, index) => const SlotCard(),
                    ),
                    SizedBox(
                      height: Sizes.spacebtwitems,
                    ),
                    Text(
                      "Reason for consultation",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.grey.shade900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "reason"),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) {
                                // Return the color based on the button state
                                if (states.contains(MaterialState.pressed)) {
                                  // Color when the button is pressed
                                  return MyColors.primary.withOpacity(0.7);
                                } else {
                                  // Default color
                                  return MyColors.primary.withOpacity(0.9);
                                }
                              },
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentConfirmationPage()),
                            );
                          },
                          child: Text("Confirm Appointment")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement appointment form fields here
    return Container(
      // Form fields
      child: Text('Appointment Form'),
    );
  }
}

class AppointmentConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FormDivider(dark: dark, dividerText: "Confirmation Details"),
              SizedBox(
                height: 16,
              ),
              Text(
                "Name : ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey.shade900),
              ),
              Text(
                "Doctor : ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey.shade900),
              ),
              Text(
                "Reason : ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey.shade900),
              ),
              Text(
                "Date : ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey.shade900),
              ),
              Text(
                "Time : ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.grey.shade900),
              ),
              SizedBox(
                height: 16,
              ),
              FormDivider(dark: dark, dividerText: ""),
              Text(
                'Appointment Booked Successfully!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the home page
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
