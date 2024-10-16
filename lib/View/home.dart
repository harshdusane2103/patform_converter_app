import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patform_converter_app/Controller/controller.dart';
import 'package:patform_converter_app/View/utils/golbal.dart';
import 'package:patform_converter_app/main.dart';

var controller = Get.put(DataController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Platfrom Convter'),
          actions: [
            Obx(
                  () =>
                  Switch(
                    // onFocusChange: v,
                    value: data.value,
                    onChanged: (value) {
                      data.value = !data.value;
                    },
                  ),
            )
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            indicatorPadding: EdgeInsets.zero,
            labelStyle: TextStyle(
              // color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            isScrollable: true,
            indicatorColor: Colors.purple,
            tabs: [
              Tab(
                icon: Icon(Icons.person_add_alt),
              ),
              Tab(text: 'Call'),
              Tab(text: 'Chats'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(children: [
          //add user
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        String path = xFile!.path;
                        File fileImage = File(path);
                        controller.getImg(fileImage);
                      },
                      child: Obx(
                            () =>
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: (controller.ImgPath != null)
                                  ? FileImage(controller.ImgPath!.value)
                                  : NetworkImage(controller.dummyImage.value),

                            ),
                      )),

                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        hintText: 'Full Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Phone',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),
                        // border:OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5),
                        //   borderSide: BorderSide(color: Colors.black,width: 1),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.chat),
                        hintText: 'Chat Conversation',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),
                        // border:OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5),
                        //   borderSide: BorderSide(color: Colors.black,width: 1),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,
                                width: 1)),
                      )),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today),
                      TextButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(1947),
                              lastDate: DateTime(2025),
                              initialDate: DateTime.now(),
                            );
                          },
                          child: Text('Pick date'))
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.watch_later_outlined),
                      TextButton(
                          onPressed: () {
                            showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                          },
                          child: Text('Pick Time'))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String d1 = controller.txtName.text;
                        String d2 = controller.txtPhone.text;
                        String d3 = controller.txtChat.text;
                        String time = controller.selectDate.toString();
                        String time2 = controller.selectedTime.toString();
                        controller.insertRecord(d1, d2, d3, controller.ImgPath!.value.path, time, time2);
                        print(controller.ImgPath!.value.path);

                        controller.txtName.clear();
                        controller.txtPhone.clear();
                        controller.txtChat.clear();

                      },
                      child: Text('Save')),
                ],
              ),
            ),
          ),
          //call
          Obx(
                () => ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onLongPress: () {
                    controller.removeRecords(
                      int.parse(
                        controller.DataList[index]['id'].toString(),
                      ),
                    );
                    // chatController.DataList[index]['id'];
                  },

                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          "Update your record",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                    () => GestureDetector(
                                  onTap: () async {
                                    ImagePicker imagePicker =
                                    ImagePicker();
                                    XFile? xFile =
                                    await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    String path = xFile!.path;
                                    File fileImage = File(path);
                                    controller.getImg(fileImage);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                      File(
                                        controller.DataList[index]
                                        ['img'],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: controller.txtName,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  hintText: controller.DataList[index]
                                  ['Name']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: controller.txtPhone,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  hintText: controller.DataList[index]
                                  ['Phone']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                cursorColor: Colors.grey,
                                controller: controller.txtChat,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  hintText: controller.DataList[index]
                                  ['Chat']
                                      .toString(),
                                  labelStyle: const TextStyle(),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        // chatController.selectDate = data.toString();
                                        controller.selectDate =
                                        (await showDatePicker(
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context)
                                                  .copyWith(
                                                colorScheme:
                                                ColorScheme.light(
                                                    primary: Color(
                                                        0xff386927),
                                                    onSurface:
                                                    Colors.black,
                                                    primaryContainer:
                                                    Colors.black,
                                                    surface: color1),
                                                textButtonTheme:
                                                TextButtonThemeData(
                                                  style: TextButton
                                                      .styleFrom(
                                                    foregroundColor:
                                                    const Color(
                                                        0xff386927), // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          context: context,
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now(),
                                        ))!;
                                        // String hi = data.toString();
                                        // chatController.selectDate =
                                        //     hi;
                                      },
                                      child: const Icon(
                                        Icons.calendar_today,
                                      )),
                                  Text(
                                    '  ${controller.selectDate.day}/${controller.selectDate.month}/${controller.selectDate.year}',
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        controller.selectedTime =
                                        (await showTimePicker(
                                          builder: (context, child) {
                                            return Theme(
                                                data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                        primary:
                                                        const Color(
                                                            0xff386927),
                                                        onSurface:
                                                        Colors.black,
                                                        primaryContainer:
                                                        Colors.green,
                                                        surface: color1)),
                                                child: child!);
                                          },
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        ))!;
                                      },
                                      child: const Icon(
                                        Icons.watch_later_outlined,
                                      )),
                                  Text(
                                    '  ${controller.selectedTime.hour}:${controller.selectedTime.minute}',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // txtController.clear();
                            },
                            child: const Text('Cancel'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              String time =
                              controller.selectDate.toString();
                              String time2 =
                              controller.selectedTime.toString();
                              controller.updateRecords(
                                controller.DataList[index]['id'],
                                controller.txtName.text,
                                controller.txtChat.text,
                                controller.txtPhone.text,
                                controller.ImgPath!.value.path,
                                time,
                                time2,
                              );

                              print('${controller.txtName.text} ');

                              controller.txtName.clear();
                              controller.txtPhone.clear();
                              controller.txtChat.clear();
                              // controller.txtAmount.clear();
                              // controller.txtCategory.clear();
                              Navigator.of(context).pop();
                              // controller.isIncome.value = false;
                              // txtController.clear();/
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                  leading: Obx(
                        () => CircleAvatar(
                      backgroundImage: FileImage(
                        File(
                          controller.DataList[index]['img'],
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                      controller.DataList[index]['Name'].toString()),
                  subtitle: Text(
                      controller.DataList[index]['Chat'].toString()),
                  // subtitle: InkWell(
                  //     onTap: () {
                  //       chatController.removeRecords(
                  //         int.parse(
                  //           chatController.DataList[index]['id']
                  //               .toString(),
                  //         ),
                  //       );
                  //       // chatController.DataList[index]['id'];
                  //     },
                  //     child: Icon(Icons.delete)),
                  trailing: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width * 0.175,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          controller.DataList[index]['Time'],
                        ),
                        // child:Column(
                        //   children: [
                        //     Text(
                        //       overflow: TextOverflow.ellipsis,
                        //       chatController.DataList[index]['Time'],
                        //     ),
                        //     Text(
                        //       // overflow: TextOverflow.ellipsis,
                        //       chatController.DataList[index]['Time2'],
                        //     ),
                        //   ],
                        // )
                      ),
                      Container(
                        width: width * 0.3,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          controller.DataList[index]['Time2'],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: controller.DataList.length),
          ),



          Obx(
                () =>
                ListView.builder(
                    itemBuilder: (context, index) =>
                        Obx(
                              () =>
                              ListTile(
                                  onLongPress: () {
                                    controller.removeRecords(
                                      int.parse(
                                        controller.DataList[index]['id']
                                            .toString(),
                                      ),
                                    );
                                    // chatController.DataList[index]['id'];
                                  },
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          AlertDialog(
                                            title: const Text(
                                              "Update your record",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Form(
                                              key: formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Obx(
                                                        () =>
                                                        GestureDetector(
                                                          onTap: () async {
                                                            ImagePicker imagePicker =
                                                            ImagePicker();
                                                            XFile? xFile =
                                                            await imagePicker
                                                                .pickImage(
                                                                source:
                                                                ImageSource
                                                                    .gallery);
                                                            String path = xFile!
                                                                .path;
                                                            File fileImage = File(
                                                                path);
                                                            controller.getImg(
                                                                fileImage);
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundImage: FileImage(
                                                              File(
                                                                controller
                                                                    .DataList[index]
                                                                ['img'],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextField(
                                                    cursorColor: Colors.grey,
                                                    controller: controller
                                                        .txtName,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                      hintText: controller
                                                          .DataList[index]
                                                      ['Name']
                                                          .toString(),
                                                      labelStyle: const TextStyle(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    cursorColor: Colors.grey,
                                                    controller: controller
                                                        .txtPhone,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                      hintText: controller
                                                          .DataList[index]
                                                      ['Phone']
                                                          .toString(),
                                                      labelStyle: const TextStyle(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    cursorColor: Colors.grey,
                                                    controller: controller
                                                        .txtChat,
                                                    decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                      hintText: controller
                                                          .DataList[index]
                                                      ['Chat']
                                                          .toString(),
                                                      labelStyle: const TextStyle(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () async {
                                                            // chatController.selectDate = data.toString();
                                                            controller
                                                                .selectDate =
                                                            (await showDatePicker(
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                  data: Theme
                                                                      .of(
                                                                      context)
                                                                      .copyWith(
                                                                    colorScheme:
                                                                    ColorScheme
                                                                        .light(
                                                                        primary: Color(
                                                                            0xff386927),
                                                                        onSurface:
                                                                        Colors
                                                                            .black,
                                                                        primaryContainer:
                                                                        Colors
                                                                            .black,
                                                                        surface:
                                                                        color1),
                                                                    textButtonTheme:
                                                                    TextButtonThemeData(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                        const Color(
                                                                            0xff386927), // button text color
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child: child!,
                                                                );
                                                              },
                                                              context: context,
                                                              firstDate: DateTime(
                                                                  1950),
                                                              lastDate: DateTime
                                                                  .now(),
                                                            ))!;
                                                            // String hi = data.toString();
                                                            // chatController.selectDate =
                                                            //     hi;
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .calendar_today,
                                                          )),
                                                      Text('Dtae Pick')
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () async {
                                                            controller
                                                                .selectedTime =
                                                            (await showTimePicker(
                                                              builder: (context,
                                                                  child) {
                                                                return Theme(
                                                                    data: Theme
                                                                        .of(
                                                                        context)
                                                                        .copyWith(
                                                                        colorScheme: ColorScheme
                                                                            .light(
                                                                            primary:
                                                                            const Color(
                                                                                0xff386927),
                                                                            onSurface:
                                                                            Colors
                                                                                .black,
                                                                            primaryContainer:
                                                                            Colors
                                                                                .green,
                                                                            surface:
                                                                            color1)),
                                                                    child: child!);
                                                              },
                                                              initialTime: TimeOfDay
                                                                  .now(),
                                                              context: context,
                                                            ))!;
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .watch_later_outlined,
                                                          )),
                                                      Text('Pick Time')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  // txtController.clear();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  String time =
                                                  controller.selectDate
                                                      .toString();
                                                  String time2 =
                                                  controller.selectedTime
                                                      .toString();
                                                  controller.updateRecords(
                                                    controller
                                                        .DataList[index]['id'],
                                                    controller.txtName.text,
                                                    controller.txtChat.text,
                                                    controller.txtPhone.text,
                                                    controller.ImgPath!.value
                                                        .path,
                                                    time,
                                                    time2,
                                                  );

                                                  print('${controller.txtName
                                                      .text} ');

                                                  controller.txtName.clear();
                                                  controller.txtPhone.clear();
                                                  controller.txtChat.clear();
                                                  // controller.txtAmount.clear();
                                                  // controller.txtCategory.clear();
                                                  Navigator.of(context).pop();
                                                  // controller.isIncome.value = false;
                                                  // txtController.clear();/
                                                },
                                                child: const Text('Save'),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  leading: Obx(
                                        () =>
                                        CircleAvatar(
                                          backgroundImage: FileImage(
                                            File(
                                              controller.DataList[index]['img'],
                                            ),
                                          ),
                                        ),
                                  ),
                                  title: Text(
                                      controller.DataList[index]['Name']
                                          .toString()),
                                  subtitle: Text(
                                      controller.DataList[index]['Chat']
                                          .toString()),
                                  trailing: Icon(
                                    Icons.call,
                                    size: 30,
                                    color: Colors.green,
                                  )),
                        ),
                    itemCount: controller.DataList.length),
          ),
          //profile
          Obx(
                () =>
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        title: Text('Profile'),
                        subtitle: Text('Update Profile Data'),
                        trailing: Obx(
                              () =>
                              Switch(
                                // onFocusChange: v,
                                value: pr.value,
                                onChanged: (value) {
                                  pr.value = !pr.value;
                                },
                              ),
                        ),
                      ),
                      (pr.value)
                          ? Container(
                        width: width * 0.5,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                im != im;
                                ImagePicker imagePicker = ImagePicker();
                                XFile? xFile = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                String path = xFile!.path;
                                File fileImage = File(path);
                                // print(fileImage);
                                controller.getImg1(fileImage);
                              },
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: (controller.ImgPath1 != null)
                                    ? FileImage(controller.ImgPath1!.value)
                                    : NetworkImage(controller.dummyImage.value),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: TextField(
                                controller: controller.name,
                                decoration: InputDecoration(
                                    helperText: 'Name',
                                    hintText: (controller.name == ' ')
                                        ? 'hiii'
                                        : '${controller.name.text}'),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: TextField(
                                controller: controller.bio,
                                decoration: InputDecoration(
                                    helperText: 'Bio',
                                    hintText: (controller.bio == ' ')
                                        ? 'hiii'
                                        : '${controller.bio.text}'),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {}, child: Text('Save')),
                                TextButton(
                                    onPressed: () {
                                      controller.bio.clear();
                                      controller.name.clear();
                                    },
                                    child: Text('Clear'))
                              ],
                            )
                          ],
                        ),
                      )
                          : Column(
                        children: [],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.sunny,
                          size: 30,
                        ),
                        title: Text('Theme'),
                        subtitle: Text('Change Theme'),
                        trailing: Obx(
                              () =>
                              Switch(
                                // onFocusChange: v,
                                value: theme1.value,
                                onChanged: (value) {
                                  theme1.value = !theme1.value;
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
          )


        ]),
      ),
    );
  }
}

  // Future<void>_selectDate()
  // async {
  //   DateTime? _picked= await showDatePicker(
  //     context: context,
  //     firstDate: DateTime(1947),
  //     lastDate: DateTime(2025),
  //     initialDate:DateTime.now(),
  //   );
  //   if(_picked!=null)
  //   {
  //     setState(() {
  //       _dateController.text=_picked.toString().split(" ")[0];
  //     });
  //   }
  // }


