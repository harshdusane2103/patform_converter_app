import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patform_converter_app/DataHelper/dbhelper.dart';

class DataController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtChat = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  DateTime selectDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  //  Rx<DateTime> selectDate = DateTime.now().obs ;
  // // late Rx<DateTime?> selectDate;
  //   Rx<TimeOfDay> selectedTime =TimeOfDay.now().obs;
  Rx<File>? ImgPath;
  Rx<File>? ImgPath1;
  RxString dummyImage = 'https://img.freepik.com/premium-photo/stylish-man-flat-vector-profile-picture-ai-generated_606187-310.jpg'.obs;

  // DatabaseHelper databaseHelper = DatabaseHelper();



  RxList DataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
    getRecords();
  }

  Future insertRecord(String name, String phone, String chat, String img,
      String Time, String Time2) async {
    await DbHelper.dbHelper.insertData(
        Name: name,
        Phone: phone,
        Chat: chat,
        img: img,
        Time: Time,
        Time2: Time2);
    await getRecords();
  }


  Future initDb() async {
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  void getImg(File img) {
    ImgPath = img.obs;
  }
  void getImg1(File img) {
    ImgPath1 = img.obs;
  }

  Future getRecords() async {
    DataList.value = await DbHelper.dbHelper.readData();

    return DataList;
  }

  Future<void> removeRecords(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }

  void updateRecords(int id, String name, String phone, String chat, String img,String Time, String Time2) async {
    {
      await DbHelper.dbHelper
          .updateData(id, name, phone, chat, img,Time,Time2);
      await getRecords();
    }
  }


}