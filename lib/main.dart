import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patform_converter_app/View/cupration_page.dart';
import 'package:patform_converter_app/View/home.dart';
import 'package:patform_converter_app/View/homepage.dart';
import 'package:patform_converter_app/View/utils/golbal.dart';

void main() {
  runApp(const MyApp());
}
Color color1 = Color(0xffe5ebdd);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        home: (!data.value) ? HomeScreen() : HomePage1(),
        // theme: ThemeData(colorScheme: ColorScheme.dark()),

        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            onPrimary: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              onPrimary: Colors.white,

            )
        ),
        themeMode: (!theme1.value)?ThemeMode.light:ThemeMode.dark,


      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: (!data.value) ? HomeScreen() : HomePage1(),
//       // theme: ThemeData(colorScheme: ColorScheme.dark()),
//       theme: ThemeData(
//         brightness: Brightness.light,
//         colorScheme: const ColorScheme.light(
//           onPrimary: Colors.black,
//         ),
//       ),
//       darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           colorScheme: ColorScheme.dark(
//             onPrimary: Colors.white,
//
//           )
//       ),
//       themeMode: (!theme1.value)?ThemeMode.light:ThemeMode.dark,
//     );
//   }
// }

