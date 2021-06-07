import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:opticalapp/src/services/database.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/toast_widget.dart';

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
          Expanded(
            child: StreamBuilder(
              stream: clientStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                }
                //print('length = ${snapshot.data.docs.length}');
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        // toast('Tu cliente se ha agregado correctamente :3',
                        //     Colors.grey[200], Colors.green, 16);
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          body: Center(
                            child: Text(
                              'Estas a punto de ver la ficha de este cliente',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          title: 'Atencion',
                          desc: 'This is also Ignored',
                          btnOkOnPress: () {},
                        )..show();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(top: 10),
                        width: width,
                        height: height * .15,
                        child: Card(
                            shadowColor: lightblue,
                            elevation: 10,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        CupertinoIcons.person_crop_square,
                                        color: primaryColor,
                                        size: width * .09,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${snapshot.data.docs[index].data()["nombre_cli"]}',
                                        style: TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: secondaryColor),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.phone,
                                            size: 13,
                                          ),
                                          Text(
                                            '${snapshot.data.docs[index].data()["cel_cli"] == null ? '-' : snapshot.data.docs[index].data()["cel_cli"]}',
                                            style: TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 13.5,
                                                color: secondaryColor),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${snapshot.data.docs[index].data()["edad_cli"]}',
                                        style: TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 13.5,
                                            color: secondaryColor),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.calendar,
                                            size: 13,
                                          ),
                                          Text(
                                            '${snapshot.data.docs[index].data()["fecha_cli"]}',
                                            style: TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 13.5,
                                                color: secondaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    width: 2,
                                  )),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    height: height * .095,
                                    width: 3,
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
