import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/pages/home.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';

import '../data.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class Graficos extends StatefulWidget {
  @override
  _Graficos createState() => _Graficos();
}

class _Graficos extends State<Graficos> {
  int numeroUsuarios;
  int numeroOfertas;
  List<PopulationData> data;

  Widget build(BuildContext context) {
    Map datos = ModalRoute.of(context).settings.arguments;
    numeroUsuarios = datos['usuarios'];
    numeroOfertas = datos['ofertas'];
    data = [
      PopulationData(
          type: "Usuarios",
          number: numeroUsuarios,
          barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)),
      PopulationData(
          type: "Ofertas",
          number: numeroOfertas,
          barColor: charts.ColorUtil.fromDartColor(Colors.grey))
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadistiques RepoblemAPP'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Estadistiques actuals",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: charts.BarChart(
                      
                      _getSeriesData(),
                      
                      animate: true,
                      domainAxis: charts.OrdinalAxisSpec(
                          renderSpec:
                              charts.SmallTickRendererSpec(labelRotation: 60)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getSeriesData() {
    List<charts.Series<PopulationData, String>> series = [
      charts.Series(
          id: "Population",
          data: data,
          domainFn: (PopulationData series, _) => series.type,
          measureFn: (PopulationData series, _) => series.number,
          colorFn: (PopulationData series, _) => series.barColor)
    ];
    return series;
  }
}

class PopulationData {
  String type;
  int number;
  charts.Color barColor;
  PopulationData(
      {@required this.type, @required this.number, @required this.barColor});
}
