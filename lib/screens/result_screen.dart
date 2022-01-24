import 'package:flutter/material.dart';
import 'package:rate_19/components/calculate_button.dart';
import 'package:rate_19/components/header_logo.dart';
import 'package:rate_19/components/image_header.dart';
import '../constants.dart';
import 'input_screen.dart';

class ResultScreen extends StatelessWidget {
  final String puntaje;
  final String resultadoTexto;
  final String indicaciones;

  ResultScreen({required this.puntaje, required this.indicaciones, required this.resultadoTexto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ImageHeader(
              height: 222,
              imageUrl: 'images/welcome.png',
              child: Column(
                children: <Widget>[
                  HeaderLogo(title: 'Resultado'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mBackgroundColor, mSecondBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            resultadoTexto.toUpperCase(),
                            style: (double.parse(puntaje) <= 11) ? kGreenColor : (double.parse(puntaje) >= 12 && double.parse(puntaje) <= 22) ? kYellowColor : kRedColor,
                          ),
                          Text(
                            double.parse(puntaje).toString(),
                            style: kMBITextStyle,
                          ),
                          Text(
                            indicaciones,
                            style: kResultText,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CalculateButtonComponent(
                      state: false,
                      buttonTitle: 'RE-CALCULAR',
                      // onTap: () {
                      //   Navigator.pop(context);
                      // },
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('¿Deseas calcular otra escala?'),
                          content: const Text('El resultado actual se perderá'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await Navigator.of(context)
                                    .push(new MaterialPageRoute(builder: (context) => InputScreen()));
                                // setState((){});
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}