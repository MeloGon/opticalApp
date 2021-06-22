import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticalapp/src/services/database.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/appbar_widget.dart';
import 'package:opticalapp/src/widgets/header_widget.dart';
import 'package:opticalapp/src/widgets/sizebox_widget.dart';

class FileClientPage extends StatefulWidget {
  final String userId;
  FileClientPage(this.userId);

  @override
  _FileClientPageState createState() => _FileClientPageState();
}

class _FileClientPageState extends State<FileClientPage>
    with TickerProviderStateMixin {
  double width;
  double height;

  DatabaseService databaseService = new DatabaseService();
  TextEditingController fecha = new TextEditingController();
  TextEditingController genero = new TextEditingController();
  TextEditingController edad = new TextEditingController();
  TextEditingController nombre = new TextEditingController();
  TextEditingController telefono = new TextEditingController();
  TextEditingController vendedor = new TextEditingController();
  TextEditingController odesfle = new TextEditingController();
  TextEditingController odcille = new TextEditingController();
  TextEditingController odejele = new TextEditingController();
  TextEditingController odesfce = new TextEditingController();
  TextEditingController odcilce = new TextEditingController();
  TextEditingController odejece = new TextEditingController();
  TextEditingController oiesfle = new TextEditingController();
  TextEditingController oicille = new TextEditingController();
  TextEditingController oiejele = new TextEditingController();
  TextEditingController oiesfce = new TextEditingController();
  TextEditingController oicilce = new TextEditingController();
  TextEditingController oiejece = new TextEditingController();
  TextEditingController odadd = new TextEditingController();
  TextEditingController oiadd = new TextEditingController();
  TextEditingController oddp = new TextEditingController();
  TextEditingController oidp = new TextEditingController();
  TextEditingController dptotal = new TextEditingController();
  TextEditingController obscli = new TextEditingController();

  var resp;
  bool loading;
  bool enabledTextField = false;
  bool isEditing = false;
  var inputDeactivate = InputBorder.none;
  TextStyle styleGeneral =
      TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Regular');
  TextStyle styleHeader =
      TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'SemiBold');
  TextStyle styleSubHeader =
      TextStyle(color: Colors.black, fontSize: 13.5, fontFamily: 'SemiBold');

  getData() async {
    return await databaseService.getDataUser(widget.userId);
  }

  updateData() {
    setState(() {
      enabledTextField = true;
      isEditing = true;
    });
  }

  @override
  void initState() {
    databaseService.getDataUser(widget.userId).then((value) {
      setState(() {
        resp = value;
        loading = false;
        fecha.text = resp.data()['fecha_cli'];
        genero.text = resp.data()['genero_cli'];
        edad.text = resp.data()['edad_cli'];
        nombre.text = resp.data()['nombre_cli'];
        telefono.text = resp.data()['cel_cli'];
        vendedor.text = resp.data()['vende_cli'];
        //derecho
        odesfle.text = resp.data()['od_esf_le'];
        odcille.text = resp.data()['od_cil_le'];
        odejele.text = resp.data()['od_eje_le'];
        odesfce.text = resp.data()['od_esf_ce'];
        odcilce.text = resp.data()['od_cil_ce'];
        odejece.text = resp.data()['od_eje_ce'];
        //izquierdo
        oiesfle.text = resp.data()['oi_esf_le'];
        oicille.text = resp.data()['oi_cil_le'];
        oiejele.text = resp.data()['oi_eje_le'];
        oiesfce.text = resp.data()['oi_esf_ce'];
        oicilce.text = resp.data()['oi_cil_ce'];
        oiejece.text = resp.data()['oi_eje_ce'];
        //observaciones
        obscli.text = resp.data()['obs_cli'];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    fecha.dispose();
    genero.dispose();
    edad.dispose();
    nombre.dispose();
    telefono.dispose();
    vendedor.dispose();
    //derecho
    odesfle.dispose();
    odcille.dispose();
    odejele.dispose();
    odesfce.dispose();
    odcilce.dispose();
    odejece.dispose();
    //izquierdo
    oiesfle.dispose();
    oicille.dispose();
    oiejele.dispose();
    oiesfce.dispose();
    oicilce.dispose();
    oiejece.dispose();
    //observaciones
    obscli.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: appBarWid(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              updateData();
            },
            child: isEditing ? Text('GUARDAR') : Text('EDITAR'),
            style: TextButton.styleFrom(
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          )
        ],
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // Text(widget.userId),
                    // Text(resp.data()["vende_cli"]),

                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'FECHA DE REGISTRO',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: fecha,
                    ),
                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'GÉNERO',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: genero,
                    ),
                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'EDAD',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: edad,
                    ),
                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'NOMBRE DEL CLIENTE',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: nombre,
                    ),
                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'TELEFONO',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: telefono,
                    ),
                    TextField(
                      style: styleGeneral,
                      decoration: new InputDecoration(
                        labelText: 'VENDEDOR',
                        border: inputDeactivate,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      enabled: enabledTextField,
                      controller: vendedor,
                    ),
                    headerWid(
                      width,
                      height * 0.05,
                      'Medida Ojo Derecho',
                      Icon(
                        CupertinoIcons.eye,
                        size: 35,
                        color: secondaryColor,
                      ),
                    ),
                    sizedBoxSpace(20),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('   '),
                              Text(
                                'ESF',
                                style: styleSubHeader,
                              ),
                              Text(
                                'CIL',
                                style: styleSubHeader,
                              ),
                              Text(
                                'EJE',
                                style: styleSubHeader,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Lejos ',
                                style: styleSubHeader,
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odesfle,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odcille,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odejele,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Cerca',
                                style: styleSubHeader,
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odesfce,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odcilce,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odejece,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxSpace(20),
                    headerWid(
                      width,
                      height * 0.05,
                      'Medida Ojo Izquierdo',
                      Icon(
                        CupertinoIcons.eye,
                        size: 35,
                        color: secondaryColor,
                      ),
                    ),
                    sizedBoxSpace(20),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('   '),
                              Text(
                                'ESF',
                                style: styleSubHeader,
                              ),
                              Text(
                                'CIL',
                                style: styleSubHeader,
                              ),
                              Text(
                                'EJE',
                                style: styleSubHeader,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Lejos ',
                                style: styleSubHeader,
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oiesfle,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oicille,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oiejele,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Cerca',
                                style: styleSubHeader,
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oiesfce,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oicilce,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: oiejece,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    headerWid(
                      width,
                      height * 0.05,
                      'DP Ajustes',
                      Icon(
                        CupertinoIcons.gear_alt,
                        size: 35,
                        color: secondaryColor,
                      ),
                    ),
                    sizedBoxSpace(20),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('   '),
                              Text(
                                'DER',
                                style: styleSubHeader,
                              ),
                              Text(
                                'IZQ',
                                style: styleSubHeader,
                              ),
                              Text(
                                'TOTAL',
                                style: styleSubHeader,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'DP ',
                                style: styleSubHeader,
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odesfle,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odcille,
                                ),
                              ),
                              Container(
                                width: width * .2,
                                child: TextField(
                                  style: styleGeneral,
                                  decoration: new InputDecoration(
                                    border: inputDeactivate,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  enabled: enabledTextField,
                                  controller: odejele,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: TextField(
                        style: styleGeneral,
                        enabled: enabledTextField,
                        controller: obscli,
                        maxLines: 10,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            labelText: 'Observaciones',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}