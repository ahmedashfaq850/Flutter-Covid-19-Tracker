import 'package:flutter/material.dart';

class mostAffected extends StatelessWidget {

  final countryData;

  mostAffected(this.countryData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal:10, vertical:10),
            child: Row(
              children: [
                Image.network(countryData[index]['countryInfo']['flag'],width: 50,),
                SizedBox(width:15),
                Text(countryData[index]['country'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(width:10),
                Text('Deaths: ' +countryData[index]['deaths'].toString(),style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500),),

              ],
            ),
          );
        }),
    );
  }
}