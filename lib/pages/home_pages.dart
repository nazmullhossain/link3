import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../controller/get_controller_data.dart';
import 'graph_pages.dart';
import 'alarmHomeScreen.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    GetController.subscription!.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>AlarmHomeScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Color(0xff33CCCC),
                    borderRadius: BorderRadius.circular(10)

                  ),
                  child: Text("Todo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SensorHomePage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)

                  ),
                  child: Text("Sensor Tracking",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
