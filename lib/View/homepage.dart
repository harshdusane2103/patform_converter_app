

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:patform_converter_app/Controller/controller.dart';
import 'package:patform_converter_app/View/cupration_page.dart';
import 'package:patform_converter_app/View/utils/golbal.dart';


class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var chatController = Get.put(DataController());
    return SafeArea(
        child: DefaultTabController(
          length: 4,
          child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: (theme1.value)?Colors.black:Colors.white,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Platform Convertor ',
                      style: TextStyle(
                          color: (theme1.value)?Colors.white:Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                    Obx(
                          () => CupertinoSwitch(
                        // onFocusChange: v,
                        value: data.value,
                        onChanged: (value) {
                          data.value = !data.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.person), label: 'Profile'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.chat_bubble_2), label: "Chat"),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.phone),
                      label: 'Call',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.settings), label: "Setting"),
                  ],
                ),
                tabBuilder: (context, index) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      switch (index) {
                        case 0:
                          return ColumnWidget();
                          break;
                        case 1:
                          return ColumnWidget2();
                          break;
                        case 2:
                          return ColumnWidget3();
                          break;
                        case 3:
                          return ColumnWidget4();
                          break;
                        default:
                          return Container();
                      }
                    },
                  );
                },
              )),
        ));
  }
}