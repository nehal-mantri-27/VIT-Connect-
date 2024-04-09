import 'package:flutter/material.dart';
import 'package:vit_connect_plus/features/lost_and_found/screens/lost_and_found_screen.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';

class SlotCard extends StatefulWidget {
  const SlotCard({Key? key}) : super(key: key);

  @override
  _SlotCardState createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelected ? Colors.white : MyColors.primary.withOpacity(0.7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
            color:
                isSelected ? MyColors.primary.withOpacity(0.7) : Colors.white,
          ),
          width: 120,
          height: 50,
          child: Center(
            child: Text(
              isSelected ? "9:00-10:00" : "9:00-10:00",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
