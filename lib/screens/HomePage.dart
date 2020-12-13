import 'dart:convert';

import 'package:app/Widgets/WorldWide.dart';
import 'package:app/Widgets/mostAfftected.dart';
import 'package:app/screens/countryList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }
  List countryData;
  fetchcountryData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldData();
    fetchcountryData();
    print("Done");
  }


  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff192841),
            title: Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Text("Covid 19 Tracker",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
          ),
            ),
        ),
        body:RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("World Wide",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                        Container(
                          padding: EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                            color: Color(0xff192841),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            child: Text("Region",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => countryPage()));
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:30),
                    worldData == null ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xff192841),
                      ),
                    )
                    : worldWide(
                      worldData: worldData,
                    ),
                    SizedBox(height:30),
                    Text("Most Affected Countries",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                    SizedBox(height:30),
                    countryData == null ? Center(child: CircularProgressIndicator(backgroundColor: Color(0xff192841),))
                    : mostAffected(
                      countryData = countryData,
                    )
                  ],
                ),
              ),
            ),
        ),
        ),
    );
  }
}