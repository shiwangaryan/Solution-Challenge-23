// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class MedicineCard extends StatefulWidget {
  const MedicineCard({
    super.key,
    this.img,
    required this.name,
    required this.dosage,
    required this.duration,
    this.stock,
  });

  final String? img;
  final String name;
  final String dosage;
  final String duration;
  final int? stock;

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    bool isFileImage = false;
    if (widget.img != null) {
      setState(() {
        isFileImage = true;
      });
    }
    void showMedicineInfoDialogue(
        String image, String name, String dosage, String duration) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: AlertDialog(
                backgroundColor: Colors.white.withOpacity(0.88),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          'Your Medicine',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 1),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    )
                  ],
                ),
                content: Form(
                  child: SizedBox(
                    width: 300,
                    height: 380,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isFileImage
                            ? Container(
                                width: 300,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(image)),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              )
                            : Container(
                                width: 300,
                                height: 250,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/medicine/default_meds.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                        SizedBox(height: 30),
                        Text(
                          'Name: $name',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Duration:  $duration',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Dosage:  $dosage',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        showMedicineInfoDialogue(
          isFileImage ? widget.img! : 'assets/medicine/default_meds.jpg',
          widget.name,
          widget.duration,
          widget.dosage,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFileImage
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(widget.img!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/medicine/default_meds.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Dosage:  ${widget.dosage}',
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
