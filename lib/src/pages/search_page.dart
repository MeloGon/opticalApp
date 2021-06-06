import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opticalapp/src/services/database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double width;
  double height;
  Stream clientStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    super.initState();
    databaseService.getClient().then((value) {
      //print('VATO' + value.toString());
      setState(() {
        clientStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: clientList(),
    );
  }

  Widget clientList() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: TextStyle(fontFamily: 'Regular', fontSize: 14),
              decoration: InputDecoration(
                suffixIcon: Icon(CupertinoIcons.search),
                labelText: 'Buscar',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: clientStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              //print('length = ${snapshot.data.docs.length}');
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    height: height * .15,
                    child: Card(
                        elevation: 10,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${snapshot.data.docs[index].data()["nombre_cli"]}'),
                              Text(
                                  '${snapshot.data.docs[index].data()["edad_cli"]}'),
                              Text(
                                  '${snapshot.data.docs[index].data()["fecha_cli"]}'),
                            ],
                          ),
                        )),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
