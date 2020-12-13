import 'package:flutter/material.dart';

class worldWide extends StatelessWidget {

  final worldData;

  const worldWide({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
      children: [
        EachContainer(
          title: 'Confirmed',
          count: worldData['cases'].toString(),
          textColor: Colors.red,
          containerColor: Color(0xfff7c5cb),
        ),
        EachContainer(
          title: 'ACTIVE',
          count: worldData['active'].toString(),
          textColor: Colors.blue[800],
          containerColor: Color(0xffb5d9fd),
        ),
        EachContainer(
          title: 'RECOVERED',
          count: worldData['recovered'].toString(),
          textColor: Colors.green[500],
          containerColor: Color(0xffc2e1c2),
        ),
        EachContainer(
          title: 'DEATHS',
          count: worldData['deaths'].toString(),
          textColor: Colors.black,
          containerColor: Colors.grey,
        ),
      ],
    ));
  }
}

class EachContainer extends StatelessWidget {

  final Color containerColor;
  final Color textColor;
  final String title;
  final String count;

  const EachContainer({Key key, this.containerColor, this.textColor, this.title, this.count}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 10,
      width: width/2,
      color: containerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: textColor)),
          Text(count,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: textColor)),
        ],
      ),
    );
  }
}