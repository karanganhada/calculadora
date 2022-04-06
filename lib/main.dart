import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<MyCalculator> {

  String equacao = "0";
  String resultado = "0";
  String expressao = "";
  double equacaoFontSize = 36.0;
  double resultadoFontSize = 46.0;

  clicarBotao(String buttonText){
      setState(() {
        if(buttonText == "C"){
            equacao = "0";
            resultado = "0";
            double equacaoFontSize = 36.0;
            double resultadoFontSize = 46.0;
        }else if(buttonText == "⌫"){
          double equacaoFontSize = 46.0;
          double resultadoFontSize = 36.0;
          equacao = equacao.substring(0, equacao.length - 1);
          if(equacao == ""){
            equacao = "0";
          }
        }else if(buttonText == "="){
          double equacaoFontSize = 36.0;
          double resultadoFontSize = 46.0;
            expressao = equacao;
            expressao = expressao.replaceAll('×', '*');
          expressao = expressao.replaceAll('÷', '/');
          try{
            Parser p = Parser();
            Expression exp = p.parse(expressao);
            ContextModel cm = ContextModel();
            resultado = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }catch(e){

          }

        }else{
          double equacaoFontSize = 46.0;
          double resultadoFontSize = 36.0;
          if(equacao == "0"){
            equacao = buttonText;
          }else {
            equacao = equacao + buttonText;
          }
        }
      });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
      return  Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.5),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => clicarBotao(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color:Colors.white
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora'),),
    body: Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0) ,
          child: Text(equacao, style: TextStyle(fontSize: equacaoFontSize),),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0) ,
          child: Text(resultado, style: TextStyle(fontSize: resultadoFontSize),),
        ),

        Expanded(
          child: Divider(),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("⌫", 1, Colors.deepOrange),
                      buildButton("%", 1, Colors.deepOrange),
                    ]
                  ),
                  TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ]
                  )
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("÷", 1, Colors.deepOrange),
                    ]
                  ),
                  TableRow(
                      children: [
                        buildButton("×", 1, Colors.deepOrange),
                      ]
                  ),TableRow(
                      children: [
                        buildButton("-", 1, Colors.deepOrange),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("+", 1, Colors.deepOrange),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("=", 1, Colors.redAccent),
                      ]
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),
    );
  }
}




