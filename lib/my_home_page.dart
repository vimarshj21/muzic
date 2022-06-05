
import 'dart:convert';

import 'package:muzic/app_colors.dart' as AppColors;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List popularBooks;

   ReadData() async {
   await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s) {
        setState(() {
          popularBooks=json.decode(s);
        });
    });
  }

  @override 
  void initState(){
    super.initState();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageIcon(
                        AssetImage("img/menu.png"),
                        size: 24,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.notifications),
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: 180,
                child: Stack(
                  children: [
                      Positioned( 
                        top: 0,
                        left: -20,
                        right: 0,
                  child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: popularBooks==null?0:popularBooks.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(popularBooks[i]["img"]),
                                fit: BoxFit.fill)),
                      );
                    }),
              )
                  )
                  ],
                ) ,
              ), 
            ],
          ),
        ),
      ),
    );
  }
}
