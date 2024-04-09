import 'package:get/get.dart';
import 'package:vit_connect_plus/features/healthcare/screens/book_appointment_screen.dart';

class AppointmentController extends GetxController {
  void goToBookAppointment() {
    Get.to(DoctorAppointmentPage(
      doctorName: "John Doe",
    ));
  }
}
