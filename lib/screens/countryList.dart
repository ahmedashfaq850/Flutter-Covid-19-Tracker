import 'package:app/screens/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class countryPage extends StatefulWidget {
  @override
  _countryPageState createState() => _countryPageState();
}

class _countryPageState extends State<countryPage> {

  List countriesdata;

  fetchcountryData() async{
    http.Response response = await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countriesdata = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchcountryData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff192841),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                showSearch(context: context, delegate: Search(countriesdata));
              })
            ],
            title: Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Text("Country Stats",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
          ),
            ),
        ),
        body: countriesdata == null ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: countriesdata == null ? 0 : countriesdata.length,
          itemBuilder: (context, index){
            return Card(
              child: Container(
                height: 130,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(countriesdata[index]['country'],style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        SizedBox(height:10),
                        Image.network(countriesdata[index]['countryInfo']['flag'],width: 80,)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Confirmed: '+countriesdata[index]['cases'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                      Text('Active: '+countriesdata[index]['active'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                      Text('Recovered: '+countriesdata[index]['recovered'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                      Text('Deaths: '+countriesdata[index]['deaths'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    ],)
                  ],
                ),
              ),
            );
          })
      );
  }
}