import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repoblemapp/models/User.dart';
import 'package:repoblemapp/models/Offer.dart';
import 'package:repoblemapp/pages/my_offers.dart';
import 'package:repoblemapp/services/offer_service.dart';
import 'package:repoblemapp/services/user_service.dart';
import 'package:repoblemapp/widgets/error_toast.dart';

class CreateOffer extends StatefulWidget {
  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  var lista = ["Barcelona", "Lleida", "Girona", "Tarragona"];
  var serveis = ["Aire acondicionat", "Local inclòs", "Supermercats"];
  String vista = "Seleccioni la província";
  String vista2 = "Seleccioni els serveis";
  final titleInputController = TextEditingController();
  //final fotos que nose como añadirlas
  final priceInputController = TextEditingController();
  final descriptionInputController = TextEditingController();
  final villageInputController = TextEditingController();
  final provinceInputController = DropdownButton();
  final placeInputController = TextEditingController(); //direccion 
  final latInputController = TextEditingController();
  final longInputController = TextEditingController();
  final servicesInputController = FilterChipWidget();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            'Crea una nova oferta',
            style: TextStyle(
              fontFamily: 'Hontana',
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        backgroundColor: Colors.teal[400],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/profile");
          },
        ),
        
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
        Expanded(
          child: Stack(

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
                
                ListView(
                  children: [
                    //Titol de la pagina
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 6),
                      child: Center(
                        child: Text(
                          "Omple la informació de la teva oferta",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Snidane',
                            color: Colors.teal[900],

                          ),
                        ),
                      ),
                    ),

                    //Conatiner pels camps
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 4, 24, 4),
                      child: Container(
                        height: 550,
                        decoration:BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(
                            color: Colors.green[900],
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow

                          )]

                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,

                          child: ListView(

                            children: [

                              //NOM oferta
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },

                                  controller: titleInputController,
                                  decoration: InputDecoration(
                                    border:  InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.title,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Nom de la oferta",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,


                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Preu de la oferta
                              Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                              controller: priceInputController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.euro,
                                    color: Colors.green,
                                    size: 35,),
                                ),
                                hintText: "Preu",//'Ingressa el preu de la oferta',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[900],
                                ),
                              ),
                              // Formato del teclado de entrada
                              keyboardType: TextInputType.number, //Formato de texto numero
                              textInputAction: TextInputAction.next,

                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[900],
                              ),
                              ),
                            ),

                              //description
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: descriptionInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.description_outlined,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Description",//'Ingressa la descripció de la oferta',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Village
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: villageInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.location_city,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Poble on es troba la oferta",//'Poble de la oferta',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Provincia
                              Padding(
                                
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: DropdownButton(
                                  
                                  items: lista.map((String a){
                                    return DropdownMenuItem(
                                      value: a,
                                      child: Text(a));

                                  }).toList(),
                                  onChanged: (value)=>{
                                    setState((){
                                      vista=value;
                                    })
                                  },
                                  hint: Text(vista),
                                  
                                ),
                              ),

                              //Direcció (carrer tal...)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },

                                  controller: placeInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.directions,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Direcció (carrer, avinguda...)",//'Ingressa el teu nom',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              //Coordinates (latitud)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: latInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.location_history,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Introdueix les coordenades (Latitud)",//'Ingressa les coordenades',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),
                              //Coordinates (Longitud)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty) {
                                      return 'Camp Obligatori';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  controller: longInputController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.location_history,
                                        color: Colors.green,
                                        size: 35,),
                                    ),
                                    hintText: "Introdueix les coordenades (Longitud)",//'Ingressa les coordenades',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal[900],
                                    ),
                                  ),
                                  // Formato del teclado de entrada
                                  keyboardType: TextInputType.text, //Formato de texto normal
                                  textInputAction: TextInputAction.next,

                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[900],
                                  ),
                                ),
                              ),

                              /*//serveis
                              Padding(
                                
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: DropdownButton(
                                  
                                  items: serveis.map((String a){
                                    return DropdownMenuItem(
                                      value: a,
                                      child: Text(a));

                                  }).toList(),
                                  onChanged: (value)=>{
                                    setState((){
                                      vista2=value;
                                    })
                                  },
                                  hint: Text(vista2),
                                  
                                ),
                              ),
                              */
                              //INTENTO DE MULTISELECT PARA LOS SERVICIOS
                              Align
                                (
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _TitleContainer("Seleccioni els serveis "),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Align
                                  (
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      child: Wrap(
                                        spacing: 5.0,
                                        runSpacing: 3.0,
                                        children: <Widget>[
                                          FilterChipWidget(chipName: 'Aire acondicionat'),
                                          FilterChipWidget(chipName: 'Supermercat aprop'),
                                          FilterChipWidget(chipName: 'Piscina'),
                                          FilterChipWidget(chipName: 'Terrassa'),
                                          FilterChipWidget(chipName: 'Parking'),
                                          FilterChipWidget(chipName: 'Local inclòs'),

                                        ],
                                      )
                                  ),
                                ),
                              ),
                              
                            ],
                      ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal[900],
                            elevation: 5,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),),



                          onPressed: () async{
                            //Funció per registar l'usuari
                            //Comprovem que tots els camps estan omplerts

                            if(_formKey.currentState.validate()) {
                              //Retorna True si tots els camps obligatoris estan plens i les contraseñes i corres es repeteixen correctament
                              //Hem d'agafar la instancia de Offer manage
                              OffersManager manager = OffersManager.getInstance();
                              //Creem el nou usuari
                              Offer createdOffer = new Offer(
                                title: titleInputController.text,
                                description: descriptionInputController.text,
                                province: provinceInputController.onChanged.toString(),
                                ubication: placeInputController.text,
                                lat: latInputController.text,
                                long: longInputController.text,
                                village: villageInputController.text,
                                price: priceInputController.text,
                                services: servicesInputController.toString(),
                                
                              );
                              print (createdOffer);

                              int code = await manager.createOffer(createdOffer);

                              //Comprovem quin codi ens retorna i fem les differents coses
                              if(code==200){
                                //Tornem al Login amb un pop de la pagina
                                Navigator.pushNamed(context, "/login");

                              }
                              
                              else{
                                //Error en el servidor o en el guardat de dades
                                showFlash(
                                    context: context,
                                    duration: const Duration (seconds: 3),
                                    builder: (context,controller){
                                      return ErrorToast(
                                        controller: controller,
                                        textshow: "Servidor no disponible",
                                      );

                                    }
                                );
                              }
                            }
                          },
                          child: Text('Crear nova oferta',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.teal[50],
                            ),)),
                    ),
                  ],
                ),
            ],
          ),
        ),]
      ),
    );
  }
}

Widget _TitleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  FilterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.teal[900],fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Colors.teal[100],
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.teal[400],);
  }
}