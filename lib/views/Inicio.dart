import 'dart:async';

import 'package:flutter/material.dart';

class Inicio extends StatefulWidget{
  @override
  State createState() => _InicioState();
}

class _InicioState extends State<Inicio>{
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context){
    var palabrasBebito = ['Papá'];
    var strm = new StreamController<String>(); 
    TextEditingController nuevaPalabra = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Palabras de Raquel'),
      ),
      body: SafeArea(
        child: StreamBuilder(
        stream: strm.stream,
        builder: (BuildContext, context){
          print(palabrasBebito.length);
          return ListView.builder(
            itemCount: palabrasBebito.length,
            itemBuilder: (ctxt, var index){
              return InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment(-1, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(palabrasBebito[index], style: TextStyle(fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text('Status', style: TextStyle(color: Colors.black54, fontSize: 9,)),
                              )
                            ],
                          )
                        ),
                        Container(
                          alignment: Alignment(1, 0),
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Icon(Icons.clear, size: 16, color: Colors.black54,),
                            ),
                            onTap: (){
                              strm.add('event');
                              palabrasBebito.removeLast();
                            },
                          )
                        )
                      ],
                    ),
                  )
                ),
                onTap: (){
                  // strm.add('event');
                  // palabrasBebito.removeLast();
                },
              );
            },
          );
        },
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          return showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('¿Nueva palabra?'),
                content: Container(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ingresala aquí'
                      ),
                      controller: nuevaPalabra,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese una palabra';
                        }
                        return null;
                      },
                    )
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancelar', style: TextStyle(color: Colors.black54),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Guardar', style: TextStyle(color: Colors.lightBlue),),
                    onPressed: (){
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        strm.add('event');
                        palabrasBebito.add(nuevaPalabra.text);
                        nuevaPalabra.text = '';
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}