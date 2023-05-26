import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/screens/entry/controller/entry_controller.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  EntryController controller = Get.put(EntryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff171717),
        appBar: AppBar(
          backgroundColor: Color(0xff1b1b1d),
          title: Text(
            "Income / Expenses",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      titleStyle: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xff171717),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Income / Expenses",
                              style: TextStyle(color: Colors.white),
                            ),
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
                                  value: controller.ffName.value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "  All",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: "2",
                                    ),
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
                                    controller.ffName.value = value!;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   "Category",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            // Obx(
                            //   () => Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.transparent,
                            //         border: Border.all(color: Colors.white),
                            //         borderRadius: BorderRadius.circular(5)),
                            //     alignment: Alignment.center,
                            //     child: DropdownButton(
                            //       isExpanded: true,
                            //       dropdownColor: Color(0xff1b1b1d),
                            //       value: controller.cateName.value,
                            //       items: controller.cateList
                            //           .map(
                            //             (e) => DropdownMenuItem(
                            //               value: "${e['category']}",
                            //               child: Text(
                            //                 "  ${e['category']}",
                            //                 style:
                            //                     TextStyle(color: Colors.white),
                            //               ),
                            //             ),
                            //           )
                            //           .toList(),
                            //       onChanged: (value) {
                            //         controller.cateName.value = value as String;
                            //
                            //         print(controller.ffcate);
                            //       },
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              "Payment-Method",
                              style: TextStyle(color: Colors.white),
                            ),
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
                                  value: controller.ffmethod.value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "  All",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: "All",
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "  Cash",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: "cash",
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "  Online",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: "online",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.ffmethod.value = value!;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.multiSort(statusCode: controller.ffName, method: controller.ffmethod, category: controller.ffcate);
                                Get.back();
                              },
                              child: Container(
                                height: 5.h,
                                width: 30.w,
                                // padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Filter",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: "Filter");
                },
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) => Container(
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
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
                            controller
                                .deleteDb(controller.dataList[index]['id']);
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
              ),
            ),
            itemCount: controller.dataList.length,
          ),
        ),
      ),
    );
  }
}
