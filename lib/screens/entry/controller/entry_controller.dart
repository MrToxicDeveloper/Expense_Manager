import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/entry/modal/entry_modal.dart';
import 'package:untitled/utils/db_helper/db_helper.dart';

class EntryController extends GetxController {
  Rx<DateTime> current = DateTime.now().obs;
  Rx<TimeOfDay> currenttime = TimeOfDay.now().obs;

  RxString ddName = '0'.obs;
  RxString cateName = ''.obs;

  RxString ffName = '0'.obs;
  RxString ffmethod = 'All'.obs;
  RxString ffcate = ''.obs;

  RxDouble totalAmount = 0.0.obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;

  RxList<Map> dataList = <Map>[].obs;
  RxList<Map> incomeList = <Map>[].obs;
  RxList<Map> expenseList = <Map>[].obs;
  RxList<Map> cateList = <Map>[].obs;

  RxList<DropdownMenuItem> itemList = <DropdownMenuItem>[].obs;

  Future<void> readDb() async {
    print("=========================================readcon");
    dataList.value = await DBHelper.dbHelper.readDB();
  }

  Future<void> readOnlyIncome() async {
    incomeList.value = await DBHelper.dbHelper.readIncome();
  }

  void totalIncomeAmount() {
    readOnlyIncome();
    totalIncome.value = 0;

    for (int i = 0; i < incomeList.length; i++) {
      String value = incomeList[i]['amount'];
      int amount = int.parse(value);
      totalIncome.value = totalIncome.value + amount;
    }
  }

  Future<void> readOnlyExpense() async {
    expenseList.value = await DBHelper.dbHelper.readExpense();
  }

  void totalBalance() {
    readDb();
    totalAmount.value = 0;

    totalAmount.value = totalIncome.value - totalExpense.value;
  }

  void totalExpenseAmount() {
    readOnlyExpense();
    totalExpense.value = 0;

    for (int i = 0; i < expenseList.length; i++) {
      String value = expenseList[i]['amount'];
      int amount = int.parse(value);
      totalExpense.value = totalExpense.value + amount;
    }

    print(
        "======================================================totalIncomeAmount");
  }

  Future<void> readDb2() async {
    print("=========================================readcon");
    cateList.value = await DBHelper.dbHelper.readDB2();
    cateName.value = cateList[0]['category'];
  }

  void updateDb({required EntryModel e1, required int Id}) {
    DBHelper.dbHelper.updateDB(e1, Id);
    readDb();
  }

  void deleteDb(int Id) {
    DBHelper.dbHelper.deleteDB(Id);
    readDb();
  }

  Future<void> IEFilter(String status) async {
    if (status != "2") {
      dataList.value = await DBHelper.dbHelper.IEFilter(status);
    } else {
      readDb();
    }
  }

  Future<void> categoryFilter(String cate) async {
    if (cate != "") {
      dataList.value = await DBHelper.dbHelper.categoryFilter(cate);
      ffcate.value = cateList[0]['category'];
    } else {
      readDb();
    }
  }

  Future<void> methodFilter(String method) async {
    if (method != "") {
      dataList.value = await DBHelper.dbHelper.methodFilter(method);
    } else {
      readDb();
    }
  }

  Future<void> multiSort({
    required statusCode,
    required method,
    required category,
  }) async {
    print(
        "==============================================================multisort");
    if (statusCode == "2" && method == "All" && category == "") {
      readDb();
    } else {
      dataList.value = await DBHelper.dbHelper.multiSort(
          statusCode: statusCode, method: method, category: category);
    }
  }
}
