import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  void initState() {
    super.initState();
  }

  UsersManager manager = UsersManager.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Minim 2',
          ),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              child: Center(
                  child: Text(
                      "Este usuario se eliminará permanentemente de la base de datos, estas seguro que deseas eliminarlo?")),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[900],
                    elevation: 5,
                    padding: EdgeInsets.all(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () async {
                    print("Elimino");

                    await manager.deleteUser();

                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.teal[50],
                    ),
                  )),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[900],
                        elevation: 5,
                        padding: EdgeInsets.all(25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        print("No Elimino");
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Rechazar',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.teal[50],
                        ),
                      )))),
          Expanded(
            flex: 3,
            child: Container(),
          )
        ],
      ),
    );
  }
}
