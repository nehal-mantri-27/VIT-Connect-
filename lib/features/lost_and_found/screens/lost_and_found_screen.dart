import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vit_connect_plus/common/styles/shadows.dart';
import 'package:vit_connect_plus/common/widgets/appbar.dart';
import 'package:vit_connect_plus/common/widgets/rounded_image.dart';
import 'package:vit_connect_plus/features/lost_and_found/widgets/found_card_vertical.dart';
import 'package:vit_connect_plus/features/lost_and_found/widgets/lost_grid_view.dart';
import 'package:vit_connect_plus/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vit_connect_plus/utils/constants/sizes.dart';
import 'package:vit_connect_plus/utils/helpers/helper_functions.dart';

class LostAndFoundScreen extends StatelessWidget {
  const LostAndFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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

class FoundItemAdd extends StatefulWidget {
  FoundItemAdd({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<FoundItemAdd> createState() => _FoundItemAddState();
}

class _FoundItemAddState extends State<FoundItemAdd> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
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
    return FloatingActionButton(
      child: Icon(
        Iconsax.add_square,
        color: Colors.white,
      ),
      onPressed: () async {
        await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  content: SingleChildScrollView(
                    child: RoundedContainer(
                      width: double.infinity,
                      backgroundColor: Colors.white,
                      radius: 4,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -30,
                            top: -30,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 209, 94, 86),
                                child: Icon(
                                  Iconsax.clipboard_close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: widget._formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Found Something? Report It",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: OutlinedButton(
                                    onPressed: () => _selectDate(context),
                                    child: const Text('Select date'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.forward_item),
                                        labelText: "Item Name"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.location),
                                        labelText: "Found at"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.user),
                                        labelText: "Contact Info"),
                                  ),
                                ),
                                SizedBox(
                                  height: Sizes.spacebtwitems,
                                ),
                                SizedBox(
                                  height: Sizes.spaceBtwSections,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                MyColors.primary)),
                                    child: const Text('   Report Item   '),
                                    onPressed: () {
                                      if (widget._formKey.currentState!
                                          .validate()) {
                                        widget._formKey.currentState!.save();
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
      },
      backgroundColor: MyColors.primary,
    );
  }
}

class LostScreen extends StatelessWidget {
  LostScreen({
    super.key,
  });
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: LostItemAdd(formKey2: _formKey2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(""),
            LostGridView(
              itemCount: 2,
              itemBuilder: (_, index) => const FoundCardVertical(),
            )
          ],
        ),
      ),
    );
  }
}

class FoundScreen extends StatelessWidget {
  FoundScreen({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FoundItemAdd(formKey: _formKey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(""),
            FoundGridView(
              itemCount: 8,
              itemBuilder: (_, index) => const FoundCardVertical(),
            )
          ],
        ),
      ),
    );
  }
}

class FoundGridView extends StatelessWidget {
  const FoundGridView({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 316,
    required this.itemBuilder,
  });
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: mainAxisExtent),
        itemBuilder: itemBuilder);
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

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = 16,
      this.child,
      this.showBorder = false,
      this.borderColor = Colors.white70,
      this.backgroundColor = Colors.white,
      this.padding,
      this.margin});
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}

class LostItemAdd extends StatefulWidget {
  LostItemAdd({
    super.key,
    required GlobalKey<FormState> formKey2,
  }) : _formKey2 = formKey2;

  final GlobalKey<FormState> _formKey2;

  @override
  State<LostItemAdd> createState() => _LostItemAddState();
}

class _LostItemAddState extends State<LostItemAdd> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
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
    return FloatingActionButton(
      child: Icon(
        Iconsax.add_square,
        color: Colors.white,
      ),
      onPressed: () async {
        await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  content: SingleChildScrollView(
                    child: RoundedContainer(
                      width: double.infinity,
                      backgroundColor: Colors.white,
                      radius: 4,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -30,
                            top: -30,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 209, 94, 86),
                                child: Icon(
                                  Iconsax.clipboard_close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: widget._formKey2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Lost Something? Report It",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: OutlinedButton(
                                    onPressed: () => _selectDate(context),
                                    child: const Text('Select date'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.forward_item),
                                        labelText: "Item Name"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.location),
                                        labelText: "Lost at"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Iconsax.user),
                                        labelText: "Contact Info"),
                                  ),
                                ),
                                SizedBox(
                                  height: Sizes.spacebtwitems,
                                ),
                                SizedBox(
                                  height: Sizes.spaceBtwSections,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                MyColors.primary)),
                                    child: const Text('   Report Item   '),
                                    onPressed: () {
                                      if (widget._formKey2.currentState!
                                          .validate()) {
                                        widget._formKey2.currentState!.save();
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
      },
      backgroundColor: MyColors.primary,
    );
  }
}

// final api_endpoint = "http://192.168.232.237:5000/retreive_all_found_items";
//   var responseData;
//   Future<void> getLostItems() async {
//     var response = await http.get(Uri.parse(api_endpoint));
//     if (response.statusCode == 200) {
//       var decodedData = jsonDecode(response.body);
//       print(decodedData);
//     } else {
//       print("Hahaha");
//     }
//   }