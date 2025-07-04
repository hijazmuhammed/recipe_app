import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app/utility/constants.dart';
import 'package:recipe_app/widgets/food_item_display.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final CollectionReference completeApp =
      FirebaseFirestore.instance.collection('Complete-Flutter-App');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          const SizedBox(
            width: 15,
          ),
          MyIconButton(
              icon: Icons.arrow_back_ios_new,
              pressed: () {
                Navigator.pop(context);
              }),
          const Spacer(),
          const Text(
            'Quick & Easy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MyIconButton(icon: Iconsax.notification, pressed: () {}),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 5),
          child: Column(
            children: [
                const SizedBox(height: 10,),
              StreamBuilder(
                stream: completeApp.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return GridView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.78,
                        ),
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Column(
                            children: [
                              FoodItemDisplay(
                                  documentSnapshot: documentSnapshot),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.star1,
                                    color: Colors.amberAccent,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    documentSnapshot['rating'],
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text("/5"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${documentSnapshot['reviews'.toString()]} Reviews",
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
