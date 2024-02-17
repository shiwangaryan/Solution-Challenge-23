import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/medicine/model/medicine_card_class.dart';
import 'package:solution_challenge_app/features/medicine/screen/widget/medicine_appbar.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  TextEditingController medicineName = TextEditingController();
  TextEditingController medicineDosage = TextEditingController();
  TextEditingController medicineDuration = TextEditingController();
  TextEditingController medicineStock = TextEditingController();
  List<MedicineCard> medicineCardList = [
    MedicineCard(name: 'aspirin', dosage: '2 times a day')
  ];

  void addMedicineCard() {
    MedicineCard medicineCard =
        MedicineCard(name: medicineName.text, dosage: medicineDosage.text);
    medicineName.clear();
    medicineDosage.clear();

    setState(() {
      medicineCardList.insert(0, medicineCard);
    });
  }

  void addMedicineDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF040404),
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child:
                  Text('Add Medicine', style: TextStyle(color: Colors.white)),
            ),
          ),
          content: Form(
            child: SizedBox(
              width: 300,
              height: 270,
              child: Column(
                children: [
                  InfoFormField(
                      text: 'Medicine name', controller: medicineName),
                  const SizedBox(height: 8),
                  InfoFormField(
                      text: 'Dosage eg: 2pm, 8pm', controller: medicineDosage),
                  const SizedBox(height: 8),
                  InfoFormField(
                      text: 'Duration eg: 4 months',
                      controller: medicineDuration),
                  const SizedBox(height: 8),
                  InfoFormField(
                      text: 'Stock available', controller: medicineStock),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[800]),
                  ),
                  onPressed: () {
                    medicineName.clear();
                    medicineDosage.clear();
                    medicineDuration.clear();
                    medicineStock.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[800]),
                  ),
                  onPressed: () => {
                    addMedicineCard(),
                    Navigator.pop(context),
                  },
                  child: const SizedBox(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //main return of th ebuild function
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFF55d0ff),
            Color(0XFF0080bf),
          ],
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: MedicinePageAppbar(),
            body: Column(
              children: [
                const SizedBox(height: 36),
                const Center(
                  child: Text(
                    'Ongoing Medication',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(
                      width: 385,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 260,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 20,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: medicineCardList.length,
                        itemBuilder: (context, index) {
                          return medicineCardList[index];
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            right: 26,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(60),
              ),
              child: IconButton(
                onPressed: () {
                  addMedicineDialogue();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// other widgets
class InfoFormField extends StatelessWidget {
  const InfoFormField({
    super.key,
    required this.text,
    required this.controller,
  });

  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.black54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.95),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
      ),
    );
  }
}
