import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _formKey = GlobalKey<FormState>();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var _infoText = "Informe seus dados!";

  void _reset(){
    setState(() {
      pesoController.text= "";
      alturaController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      var peso = double.parse(pesoController.text);
      var altura = double.parse(alturaController.text);
      var imc = peso/(altura*altura);

      if(imc<18.5){
        _infoText = "Abaixo do peso!";
      }
      else if(imc >=18.5 && imc <24.9){
        _infoText = "Peso norma!";
      }
      else if(imc >=25 && imc <29.9){
        _infoText = "Sobrepeso!";
      }
      else if(imc >=30 && imc <34.9){
        _infoText = "Obesidade grau I!";
      }
      else if(imc >=35 && imc <39.9){
        _infoText = "Obesidade grau II!";
      }
      else if(imc >=40){
        _infoText = "Obesidade grau III ou Mórbida!";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_pin,
                color: Colors.green,
                size: 120.0,
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Colors.green)),
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              RaisedButton(
                color: Colors.green,
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                   _calcular();
                  }
                },
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
