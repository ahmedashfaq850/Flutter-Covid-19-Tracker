import 'package:flutter/material.dart';



class Search extends SearchDelegate{

  final List countriesdata;

  Search(this.countriesdata);

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: (){
          query = '';
        })
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
        Navigator.pop(context);
      });
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {

      final suggestionList = query.isEmpty ? countriesdata
      : countriesdata.where((element) => element['country'].toString().toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
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
                        Text(suggestionList[index]['country'],style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        SizedBox(height:10),
                        Image.network(suggestionList[index]['countryInfo']['flag'],width: 80,)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Confirmed: '+suggestionList[index]['cases'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                      Text('Active: '+suggestionList[index]['active'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                      Text('Recovered: '+suggestionList[index]['recovered'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                      Text('Deaths: '+suggestionList[index]['deaths'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    ],)
                  ],
                ),
              ),
            );
      });
  }


}