import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/screens/entry/controller/entry_controller.dart';

import '../../../utils/db_helper/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EntryController controller = Get.put(EntryController());

  TextEditingController txtamount = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  TextEditingController txtmethod = TextEditingController();

  TextEditingController txtaddc = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.readDb();
    controller.totalIncomeAmount();
    controller.totalExpenseAmount();
    controller.totalBalance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff171717),
        appBar: AppBar(
          backgroundColor: Color(0xff1b1b1d),
          title: Text(
            "Dashboard",
            style: TextStyle(

              color: Colors.white,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  contentPadding: EdgeInsets.all(10),
                  title: "Add Category",
                  content: Column(
                    children: [
                      TextField(
                        controller: txtaddc,
                        // style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Add category",
                          // hintStyle: TextStyle(color: Colors.white),
                          // border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              DBHelper.dbHelper.insertDB2(txtaddc.text);
                              txtaddc.clear();

                              // controller.itemList.add(dropDownItem(name: txtaddc.text));

                              Get.back();
                            },
                            child: Text("Add"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 10,
                width: 30.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                alignment: Alignment.center,
                child: Text("Add category"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 20.h,
                  width: double.infinity,
                  color: Colors.white12,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "TOTAL BALANCE",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                      SizedBox(height: 10,),
                      Obx(
                            () => Text(
                          " ${controller.totalAmount.value.toInt()}",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 15.h,
                        width: 20.h,
                        padding: EdgeInsets.all(15),
                        color: Colors.white12,
                        alignment: Alignment.center,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.download_sharp,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            Text(
                              "INCOME",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.sp),
                            ),
                            SizedBox(height: 10,),
                            Obx(
                              () => Text(
                                "${controller.totalIncome.value.toInt()}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Container(
                        height: 15.h,
                        width: 20.h,
                        padding: EdgeInsets.all(15),
                        color: Colors.white12,
                        alignment: Alignment.center,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.upload_sharp,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Text(
                              "EXPENSE",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.sp),
                            ),

                            SizedBox(height: 10,),
                            Obx(
                                  () => Text(
                                "${controller.totalExpense.value.toInt()}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                ListTile(
                  title: Text(
                    "Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  trailing: TextButton(onPressed: () {
                    Get.toNamed('/view');
                  },child: Text("see all")),
                ),
                Container(
                  height: 275,
                  child: Obx(
                    () => ListView.builder(
                      itemBuilder: (context, index) => Container(
                        height: 100,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: controller.dataList[index]['status'] == 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${controller.dataList[index]['category']}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 70,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${controller.dataList[index]['method']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "${controller.dataList[index]['amount']}",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed('/update', arguments: index);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {

                                      controller.deleteDb(
                                          controller.dataList[index]['id']);
                                      controller.totalIncomeAmount();
                                      controller.totalExpenseAmount();
                                      controller.totalBalance();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // trailing: PopupMenuButton(
                          //   itemBuilder: (context) => [
                          //
                          //     PopupMenuItem(
                          //       child: Text(
                          //         "Edit",
                          //       ),
                          //       value: "Edit",
                          //       onTap: () {
                          //         print("updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
                          //         Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(),));
                          //       },
                          //     ),PopupMenuItem(
                          //       child: Text(
                          //         "Delete",
                          //         style: TextStyle(color: Colors.red),
                          //       ),
                          //       value: "Delete",
                          //       onTap: () {
                          //         controller.deleteDb(
                          //             controller.dataList[index]['id']);
                          //       },
                          //     ),
                          //   ],
                          //   child: Icon(
                          //     Icons.more_vert,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ),
                      ),
                      itemCount: controller.dataList.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              controller.readDb2();
              Get.toNamed('/entry');
            },
            child: Icon(Icons.add),
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
