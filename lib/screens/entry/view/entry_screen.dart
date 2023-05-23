import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/screens/entry/controller/entry_controller.dart';
import 'package:untitled/screens/entry/modal/entry_modal.dart';
import 'package:untitled/utils/db_helper/db_helper.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  TextEditingController txtmethod = TextEditingController();

  EntryController entryController = Get.put(EntryController());

  @override
  void initState() {
    super.initState();
    entryController.readDb2();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff171717),
        appBar: AppBar(
          backgroundColor: Color(0xff1b1b1d),
          title: Obx(
            () => DropdownButton(
              dropdownColor: Color(0xff1b1b1d),
              value: entryController.ddName.value,
              items: [
                DropdownMenuItem(
                  child: Text(
                    "  Income",
                    style: TextStyle(color: Colors.green),
                  ),
                  value: "0",
                ),
                DropdownMenuItem(
                  child: Text(
                    "  Expense",
                    style: TextStyle(color: Colors.red),
                  ),
                  value: "1",
                ),
              ],
              onChanged: (value) {
                entryController.ddName.value = value!;
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                textField(controller: txtamount, hint: "Enter Amount"),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => DropdownButton(
                    isExpanded: true,
                    dropdownColor: Color(0xff1b1b1d),
                    value: entryController.cateName.value,
                    items: entryController.cateList
                        .map(
                          (e) => DropdownMenuItem(
                            value: "${e['category']}",
                            child: Text(
                              "  ${e['category']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      entryController.cateName.value = value as String;

                      print(entryController.cateName);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        entryController.current.value = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000),
                        ))!;
                      },
                      child: Container(
                        height: 8.h,
                        width: 20.h,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.date_range_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3.w),
                            Obx(
                              () => Text(
                                "${entryController.current.value.day}/${entryController.current.value.month}/${entryController.current.value.year}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    // SizedBox(width: 4.w),
                    InkWell(
                      onTap: () async {
                        entryController.currenttime.value =
                            (await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()))!;
                      },
                      child: Container(
                        height: 8.h,
                        width: 20.h,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3.w),
                            Obx(
                              () => Text(
                                "${entryController.currenttime.value.hour}:${entryController.currenttime.value.minute}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                textField(controller: txtmethod, hint: "Cash/Online"),
                // DropdownButton(
                //   value: entryController.ddMethod.value,
                //   items: [
                //     DropdownMenuItem(
                //       child: Text(
                //         "  Cash",
                //         style: TextStyle(color: Colors.green),
                //       ),
                //       value: "cash",
                //     ),
                //     DropdownMenuItem(
                //       child: Text(
                //         "  Online",
                //         style: TextStyle(color: Colors.red),
                //       ),
                //       value: "online",
                //     ),
                //   ],
                //   onChanged: (value) {
                //     entryController.ddMethod.value = value!;
                //   },
                // ),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 7.h,
            width: 30.w,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              heroTag: 'add',
              onPressed: () {
                EntryModel entryModel = EntryModel(
                    Amount: txtamount.text,
                    Category: txtcategory.text,
                    Date:
                        "${entryController.current.value.day}/${entryController.current.value.month}/${entryController.current.value.year}",
                    Time:
                        "${entryController.currenttime.value.hour}:${entryController.currenttime.value.minute}",
                    Method: txtmethod.text,
                    Status: "${entryController.ddName.value}");

                DBHelper.dbHelper.insertDB(entryModel);
                entryController.totalBalance();
                entryController.totalIncomeAmount();
                entryController.totalExpenseAmount();
                entryController.readDb();
                Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Save ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.add)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField({required controller, required hint}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          // border: OutlineInputBorder(),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Widget dropDownItem({required name}) {
    return DropdownMenuItem(
      child: Text(
        "  $name",
        style: TextStyle(color: Colors.yellow),
      ),
      value: "$name",
    );
  }
}
