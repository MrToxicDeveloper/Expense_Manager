import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/entry_controller.dart';
import '../modal/entry_modal.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  EntryController entryController = Get.put(EntryController());

  int index = Get.arguments;

  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  TextEditingController txtmethod = TextEditingController();

  @override
  Widget build(BuildContext context) {

    txtamount = TextEditingController(text: entryController.dataList[index]['amount']);
    txtcategory = TextEditingController(text: entryController.dataList[index]['category']);
    txtmethod = TextEditingController(text: entryController.dataList[index]['method']);

    entryController.ddName.value = entryController.dataList[index]['status'].toString();
    print("updateeeeeeeeeeeeeeeeeeee sceennnnnnnnnnnnnnnnnnnnnnnnnnn");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff171717),
        appBar: AppBar(
          backgroundColor: Color(0xff1b1b1d),
          title: Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              Text(
                "  Edit",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            Obx(
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
            SizedBox(width: 20,),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                textField(controller: txtamount, hint: "Enter Amount"),
                Obx(
                      () => Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: DropdownButton(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        Get.back();
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
                        child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                      ),
                    ),
                    Spacer(),
                    // SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        EntryModel e1 = EntryModel(
                            Amount: txtamount.text,
                            Category: txtcategory.text,
                            Date:
                            "${entryController.current.value.day}/${entryController.current.value.month}/${entryController.current.value.year}",
                            Time:
                            "${entryController.currenttime.value.hour}:${entryController.currenttime.value.minute}",
                            Method: txtmethod.text,
                            Status: "${entryController.ddName.value}");

                        entryController.updateDb(e1: e1, Id: entryController.dataList[index]['id']);

                        entryController.totalIncomeAmount();
                        entryController.totalBalance();
                        entryController.totalExpenseAmount();

                        Get.back();
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
                        child: Text("Done",style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                      ),
                    ),
                  ],
                ),

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
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: Container(
        //     height: 7.h,
        //     width: 30.w,
        //     child: FloatingActionButton(
        //       shape: RoundedRectangleBorder(
        //         side: BorderSide(),
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(50),
        //         ),
        //       ),
        //       heroTag: 'add',
        //       onPressed: () {
        //         EntryModel entryModel = EntryModel(
        //             Amount: txtamount.text,
        //             Category: txtcategory.text,
        //             Date:
        //             "${entryController.current.value.day}/${entryController.current.value.month}/${entryController.current.value.year}",
        //             Time:
        //             "${entryController.currenttime.value.hour}:${entryController.currenttime.value.minute}",
        //             Method: txtmethod.text,
        //             Status: "${entryController.ddName.value}");
        //
        //         DBHelper.dbHelper.insertDB(entryModel);
        //
        //         entryController.readDb();
        //         Get.back();
        //       },
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Save ",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           Icon(Icons.add)
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
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
}
