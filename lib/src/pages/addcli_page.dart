import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:opticalapp/src/services/database.dart';
import 'package:opticalapp/src/utilities/utilites.dart';
import 'package:opticalapp/src/widgets/header_widget.dart';
import 'package:opticalapp/src/widgets/toast_widget.dart';
import 'package:random_string/random_string.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({Key key}) : super(key: key);

  @override
  _AddClientPageState createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  double width;
  double height;
  String userId,
      cel_cli,
      nombre_cli,
      vende_cli,
      od_esf_le,
      od_cil_le,
      od_eje_le,
      od_esf_ce,
      od_cil_ce,
      od_eje_ce,
      oi_esf_le,
      oi_cil_le,
      oi_eje_le,
      oi_esf_ce,
      oi_cil_ce,
      oi_eje_ce,
      od_add,
      oi_add,
      od_dp,
      oi_dp,
      dp_total,
      obs_cli;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  String valueChooseGenre;
  String valueChooseOld;
  List listGenre = ['Masculino', 'Femenino', 'Homosexual', 'Lesbiana', 'Otros'];
  List listOld = [
    '0 - 14 anios',
    '15 - 24 anios',
    '25 - 59 anios',
    '60 a + anios'
  ];
  DateTime selectedDate = DateTime.now();
  TextStyle styleGeneral =
      TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Regular');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  clearSpaces() {}

  addClient() async {
    setState(() {
      _isLoading = true;
    });
    userId = randomAlphaNumeric(16);
    Map<String, String> userMap = {
      "userId": userId,
      "fecha_cli": DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
      "cel_cli": cel_cli,
      "edad_cli": valueChooseOld,
      "genero_cli": valueChooseGenre,
      "nombre_cli": nombre_cli,
      "vende_cli": vende_cli,
      "od_esf_le": od_esf_le,
      "od_cil_le": od_cil_le,
      "od_eje_le": od_eje_le,
      "od_esf_ce": od_esf_ce,
      "od_cil_ce": od_cil_ce,
      "od_eje_ce": od_eje_ce,
      "oi_esf_le": oi_esf_le,
      "oi_cil_le": oi_cil_le,
      "oi_eje_le": oi_eje_le,
      "oi_esf_ce": oi_esf_ce,
      "oi_cil_ce": oi_cil_ce,
      "oi_eje_ce": oi_eje_ce,
      "od_add": od_add,
      "oi_add": oi_add,
      "od_dp": od_dp,
      "oi_dp": oi_dp,
      "dp_total": dp_total,
      "obs_cli": obs_cli,
    };
    await databaseService.createClient(userMap, userId).then((value) {
      setState(() {
        _isLoading = false;
        toast('Tu cliente se ha agregado correctamente :3', Colors.transparent,
            Colors.green, 27);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              headerWid(
                width,
                height * 0.05,
                'Detalles de Registro',
                Icon(
                  CupertinoIcons.doc_text,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(CupertinoIcons.calendar_today),
                    label: Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: styleGeneral,
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.calendar_badge_plus),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Cambiar Fecha',
                            style: TextStyle(fontFamily: 'SemiBold'),
                          )
                        ],
                      ))
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'Datos del Cliente',
                Icon(
                  CupertinoIcons.person_alt,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton(
                  hint: Text('Genero del Cliente', style: styleGeneral),
                  icon: Icon(CupertinoIcons.chevron_down),
                  iconSize: 14,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                      color: Colors.black, fontSize: 13, fontFamily: 'Regular'),
                  value: valueChooseGenre,
                  items: listGenre.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valueChooseGenre = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton(
                  hint: Text(
                    'Rango de Edad',
                    style: styleGeneral,
                  ),
                  icon: Icon(CupertinoIcons.chevron_down),
                  iconSize: 14,
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: 'Regular'),
                  value: valueChooseOld,
                  items: listOld.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      valueChooseOld = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  onChanged: (value) => nombre_cli = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person_crop_square),
                    labelText: 'Nombre Completo del Cliente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  onChanged: (value) => cel_cli = value,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.phone),
                    labelText: 'Numero Telefonico del Cliente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: styleGeneral,
                  onChanged: (value) => vende_cli = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person_3),
                    labelText: 'Vendedor',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
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
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('ESF'),
                      Text('CIL'),
                      Text('EJE'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lejos',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_esf_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_cil_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_eje_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cerca',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_esf_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_cil_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_eje_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ADD'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_add = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('ESF'),
                      Text('CIL'),
                      Text('EJE'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lejos',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_esf_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_cil_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_eje_le = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cerca',
                        style: styleGeneral,
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_esf_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_cil_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_eje_ce = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ADD'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_add = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(''),
                      Text('DER'),
                      Text('IZQ'),
                      Text('TOTAL'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DP'),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => od_dp = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => oi_dp = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 30,
                        width: width * 0.2,
                        child: TextField(
                          onChanged: (value) => dp_total = value,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              headerWid(
                width,
                height * 0.05,
                'Observaciones',
                Icon(
                  CupertinoIcons.text_bubble,
                  size: 35,
                  color: secondaryColor,
                ),
              ),
              TextField(
                onChanged: (value) => obs_cli = value,
                maxLines: 10,
                style: styleGeneral,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: 'Observaciones', border: OutlineInputBorder()),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          clearSpaces();
                        },
                        child: Text(
                          'Limpiar Formulario',
                          style: TextStyle(fontFamily: 'Semibold'),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          addClient();
                        },
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.check_mark),
                            Text(
                              'Guardar Cliente',
                              style: TextStyle(fontFamily: 'Semibold'),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
