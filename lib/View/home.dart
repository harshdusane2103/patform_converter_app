import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Platfrom Convter'),
          actions: [
            Switch(value: false, onChanged: (value) {
              
            },)
            
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
              Tab(icon: Icon(Icons.person_add_alt),),
              Tab(text: 'Call'),
              Tab(text: 'Chats'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
              
                children: [
                  SizedBox(height: 20,),
                  CircleAvatar(
                    radius: 50,
                    child: InkWell(onTap: () {
              
                    },child: Icon(Icons.add_a_photo_outlined),),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.person_outline_outlined),
                      hintText: 'Full Name',
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5),
                         borderSide: BorderSide(color: Colors.black,width: 1)
                     ),
                      // border:OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5),
                      //   borderSide: BorderSide(color: Colors.black,width: 1),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black,width: 1)
                      ),
                      )
                    ),
                  SizedBox(height: 10,),
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.phone),
                        hintText: 'Phone',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,width: 1)
                        ),
                        // border:OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5),
                        //   borderSide: BorderSide(color: Colors.black,width: 1),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,width: 1)
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  TextField(
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.chat),
                        hintText: 'Chat Conversation',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,width: 1)
                        ),
                        // border:OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(5),
                        //   borderSide: BorderSide(color: Colors.black,width: 1),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black,width: 1)
                        ),
                      )
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today),
                      TextButton(onPressed: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(1947),
                          lastDate: DateTime(2025),
                          initialDate:DateTime.now(),
                        );
              
                      }, child: Text('Pick date'))
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.watch_later_outlined),
                      TextButton(onPressed: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now());
                      }, child: Text('Pick date'))
                    ],
                  ),
              
                ],
              ),
            ),
          ),
          Column(
            children: [
               Text('hi harsh')
            ],
          ),
        ]
        ),
      ),
    );

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

}
