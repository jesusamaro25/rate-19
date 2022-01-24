
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_19/components/calculate_button.dart';
import 'package:rate_19/components/header_logo.dart';
import 'package:rate_19/components/image_header.dart';
import 'package:rate_19/screens/result_screen.dart';
import '../calculate.dart';
import '../constants.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {

  int totalResultado = 0;
   Map finalData = {
     'edad': 3000.0,
     'comorbabilidades' : 'Ninguna',
     'temperatura': 0.0,
     'fc': 0.0,
     'fr': 0.0,
     'tam': 0.0,
     'safi': 'Normal >460',
     'musculos': 'No',
     'estertores': 'Ausentes',
     'estado': 'Vigil'
  };

//----------ZONA DE DROPDOWN COMORBILIDADES---------------
List<String> _listaComorbilidades = ['Ninguna', '1', '2-3', '>=4'];
List<DropdownMenuItem<String>> getOpcionesComorbilidadesDropdown() {
  List<DropdownMenuItem<String>> menuComorbilidades = [];
  _listaComorbilidades.forEach((element) {
    menuComorbilidades.add(DropdownMenuItem(
        child: Text(element),
    value: element,)
    );
  });
  return menuComorbilidades;
}
String _opcionComorbabilidadesSeleccionada = 'Ninguna';

//------------------ZONA DE DROPDOWN SAFI------------
  List<String> _listaSafi = ['Normal >460', 'Leve 459-310', 'Moderado 311-160', 'Severo <159'];
  List<DropdownMenuItem<String>> getOpcionesSafiDropdown() {
    List<DropdownMenuItem<String>> menuSafi = [];
    _listaSafi.forEach((element) {
      menuSafi.add(DropdownMenuItem(
        child: Text(element),
        value: element,)
      );
    });
    return menuSafi;
  }
  String _opcionSafiSeleccionada = 'Normal >460';

//------------------ZONA DE DROPDOWN ESTADO DE CONCIENCIA------------
  List<String> _listaEstado = ['Vigil', 'Agitado', 'Somnolencia', 'Estupor/Coma'];
  List<DropdownMenuItem<String>> getOpcionesEstadoDropdown() {
    List<DropdownMenuItem<String>> menuEstado = [];
    _listaEstado.forEach((element) {
      menuEstado.add(DropdownMenuItem(
        child: Text(element),
        value: element,)
      );
    });
    return menuEstado;
  }
  String _opcionEstadoSeleccionada = 'Vigil';

  //------------------ZONA DE MUSCULOS ACCESORIOS------------
  List<String> _listamusculos = ['No', 'Intercostales', 'Intercostales y subcostales', 'Aleteo nasal, inter y subcostales, ECM'];
  List<DropdownMenuItem<String>> getOpcionesMusculosDropdown() {
    List<DropdownMenuItem<String>> menuMusculos = [];
    _listamusculos.forEach((element) {
      menuMusculos.add(DropdownMenuItem(
        child: Text(element),
        value: element,)
      );
    });
    return menuMusculos;
  }
  String _opcionMusculosSeleccionada = 'No';

  //------------------ZONA DE ESTERTORES PULMONARES------------
  List<String> _listaEstertores = ['Ausentes', 'Roncus', 'Crepitantes en 1/3 de campo pulmonar', 'Crepitantes en 2/3 de campo pulmonar', ];
  List<DropdownMenuItem<String>> getOpcionesEstertoresDropdown() {
    List<DropdownMenuItem<String>> menuEstertores = [];
    _listaEstertores.forEach((element) {
      menuEstertores.add(DropdownMenuItem(
        child: Text(element),
        value: element,)
      );
    });
    return menuEstertores;
  }
  String _opcionEstertoresSeleccionada = 'Ausentes';

  int currentStep = 0;
  bool complete = false;
  bool _isKeyboardOpen = false;


  // @protected
  // void initState() {
  //   super.initState();
  //
  //   KeyboardVisibilityNotification().addNewListener(
  //     onChange: (bool visible) {
  //     setState(() {
  //       _isKeyboardOpen = visible;
  //       });
  //
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    //print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    _isKeyboardOpen = keyboardVisibilityController.isVisible;
    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      // print('Keyboard visibility update. Is visible: ${visible}');
      setState(() {
        _isKeyboardOpen = visible;
      });

    });
  }


  next() {
    currentStep + 1 !=3 ? goTo(currentStep + 1) : setState(() => complete=true);
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
      //complete=false; //OJO
    });
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  bool isNotValid() {

    if (finalData['edad'] != 3000.0 && finalData['temperatura'] != 0.0 && finalData['fc'] != 0.0 && finalData['fr'] != 0.0 && finalData['tam'] != 0.0) {
      return false;
    }
      return true;
    }

   void calculateFinalData(){
    final edadResult = (finalData['edad'] <= 30) ? 0 : (finalData['edad'] >= 31 && finalData['edad'] <= 50) ? 1 : (finalData['edad'] >= 51 && finalData['edad'] <= 70) ? 2: 3;
    final temperaturaResult = (finalData['temperatura'] < 36.5) ? 3 : (finalData['temperatura'] >= 36.5 && finalData['temperatura'] <= 37.5) ? 0 : (finalData['temperatura'] >= 37.6 && finalData['temperatura'] <= 38.5) ? 1 : (finalData['temperatura'] >= 38.6 && finalData['temperatura'] <= 39.9) ? 2: 3;
    final fcResult = (finalData['fc'] <= 49) ? 3 : (finalData['fc'] >= 50 && finalData['fc'] <= 59) ? 2 : (finalData['fc'] >= 60 && finalData['fc'] <= 79) ? 1: (finalData['fc'] >= 80 && finalData['fc'] <= 100) ? 0 : (finalData['fc'] >= 101 && finalData['fc'] <= 109) ? 1 : (finalData['fc'] >= 110 && finalData['fc'] <= 119) ? 2 : 3;
    final frResult = (finalData['fr'] < 12) ? 3 : (finalData['fr'] >= 12 && finalData['fr'] <= 20) ? 0 : (finalData['fr'] >= 21 && finalData['fr'] <= 25) ? 1 : (finalData['fr'] >= 26 && finalData['fr'] <= 30) ? 2 : 3;
    final tamResult = (finalData['tam'] <= 69) ? 3 : (finalData['tam'] >= 70 && finalData['tam'] <= 105) ? 0 : (finalData['tam'] >= 106 && finalData['tam'] <= 110) ? 1 : (finalData['tam'] >= 111 && finalData['tam'] <= 119) ? 2 : 3;
    final comorbabilidadesResult = (finalData['comorbabilidades'] == 'Ninguna') ? 0 : (finalData['comorbabilidades'] == '1') ? 1 : (finalData['comorbabilidades'] == '>=4') ? 3 : 2;
    final safiResult = (finalData['safi'] == 'Normal >460') ? 0 : (finalData['safi'] == 'Leve 459-310') ? 1 : (finalData['safi'] == 'Moderado 311-160') ? 2 : 3;
    final musculosResult = (finalData['musculos'] == 'No') ? 0 : (finalData['musculos'] == 'Intercostales') ? 1 : (finalData['musculos'] == 'Intercostales y subcostales') ? 2 : 3;
    final estertoresResult = (finalData['estertores'] == 'Ausentes') ? 0 : (finalData['estertores'] == 'Roncus') ? 1 : (finalData['estertores'] == 'Crepitantes en 1/3 de campo pulmonar') ? 2 : 3;
    final estadoResult = (finalData['estado'] == 'Vigil') ? 0 : (finalData['estado'] == 'Agitado') ? 1 : (finalData['estado'] == 'Somnolencia') ? 2 : 3;

    totalResultado = estadoResult + estertoresResult + musculosResult  + safiResult + comorbabilidadesResult + edadResult + temperaturaResult + fcResult + frResult + tamResult;
  //  print(temperaturaResult);
   }

  @override
  Widget build(BuildContext context) {

    List<Step> steps = [
      Step(
        title: const Text('Inicio'),
        isActive: finalData['edad']!= 3000.0 && finalData['comorbabilidades']!= '' ? true : false,
        state: finalData['edad']!= 3000.0 && finalData['comorbabilidades']!= '' ? StepState.complete : StepState.editing,
        content: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(labelText: 'Edad'),
              onChanged: (value) {
                if (RegExp('[0-9]+').hasMatch(value)) {
                  //print(double.parse(value));
                  finalData['edad'] = double.parse(value);
                }
              },
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Comorbilidades:',
                    style: TextStyle(
                        fontSize: 13,
                        color: mDropdownLabel,
                    ),),
                SizedBox(width: 5.0,),
                Expanded(
                  flex: 5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _opcionComorbabilidadesSeleccionada,
                    items: getOpcionesComorbilidadesDropdown(),
                    onChanged: (opt) {
                    setState(() {
                      _opcionComorbabilidadesSeleccionada = opt.toString();
                    });
                    finalData['comorbabilidades'] = opt.toString();
                  },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Estado de Conciencia:',
                    style: TextStyle(
                      fontSize: 13,
                      color: mDropdownLabel,
                    ),),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _opcionEstadoSeleccionada,
                    items: getOpcionesEstadoDropdown(),
                    onChanged: (opt) {
                      setState(() {
                        _opcionEstadoSeleccionada = opt.toString();
                      });
                      finalData['estado'] = opt.toString();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: finalData['temperatura']!= 0.0 && finalData['fc']!= 0.0 && finalData['fr']!= 0.0 && finalData['tam']!= 0.0 && finalData['safi']!= ''  ? true : false,
        state: finalData['temperatura']!= 0.0 && finalData['fc']!= 0.0 && finalData['fr']!= 0.0 && finalData['tam']!= 0.0 && finalData['safi']!= ''  ? StepState.complete : StepState.editing,
        title: const Text('Signos Vitales'),
        content: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),],
              onChanged: (value) => {
                if (RegExp('[0-9.]+').hasMatch(value)) {
               //   print(double.parse(value))
                  finalData['temperatura'] = double.parse(value)
    }
              },
              decoration: InputDecoration(labelText: 'Temperatura'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (RegExp('[0-9]+').hasMatch(value)) {
                //  print(double.parse(value));
                  finalData['fc'] = double.parse(value);
                }
              },
              decoration: InputDecoration(labelText: 'FC'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (RegExp('[0-9]+').hasMatch(value)) {
                 // print(double.parse(value));
                  finalData['fr'] = double.parse(value);
                }
              },
              decoration: InputDecoration(labelText: 'FR'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                if (RegExp('[0-9]+').hasMatch(value)) {
                 // print(double.parse(value));
                  finalData['tam'] = double.parse(value);
                }
              },
              decoration: InputDecoration(labelText: 'TAM'),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('SaFi:',
                  style: TextStyle(
                    fontSize: 13,
                    color: mDropdownLabel,
                  ),),
    SizedBox(width: 20.0,),
    Expanded(
    child: DropdownButton(
    value: _opcionSafiSeleccionada,
    items: getOpcionesSafiDropdown(),
    onChanged: (opt) {
    setState(() {
    _opcionSafiSeleccionada = opt.toString();
    });
    finalData['safi'] = opt.toString();
    },
    ),
    ),
    ],
    ),
          ],
        ),
      ),
      Step(
        isActive: finalData['musculos']!= '' && finalData['estertores']!= ''  ? true : false,
        state:finalData['musculos']!= '' && finalData['estertores']!= ''  ? StepState.complete : StepState.editing,
        title: const Text('Evaluación Clínica'),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex:3,
                  child: Text('Músculos accesorios:',
                    style: TextStyle(
                      fontSize: 13,
                      color: mDropdownLabel,
                    ),),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _opcionMusculosSeleccionada,
                    items: getOpcionesMusculosDropdown(),
                    onChanged: (opt) {
                      setState(() {
                        _opcionMusculosSeleccionada = opt.toString();
                      });
                      finalData['musculos'] = opt.toString();
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Estertores Pulmonares:',
                    style: TextStyle(
                      fontSize: 13,
                      color: mDropdownLabel,
                    ),),
                ),
                Expanded(
                  flex: 5,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _opcionEstertoresSeleccionada,
                    items: getOpcionesEstertoresDropdown(),
                    onChanged: (opt) {
                      setState(() {
                        _opcionEstertoresSeleccionada = opt.toString();
                      });
                      finalData['estertores'] = opt.toString();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: _isKeyboardOpen ? 1 : 3,
              child: _isKeyboardOpen ? Container() : ImageHeader(
                height: 222,
                imageUrl: 'images/welcome.png',
                child: Column(
                  children: <Widget>[
                    HeaderLogo(title: 'Formulario'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: _isKeyboardOpen ? 10 : 7,
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
                        child: Theme(
                          data: ThemeData(
                              accentColor: mButtonColor,
                              primaryColor: mButtonColor,
                              colorScheme: ColorScheme.light(
                                  primary: mButtonColor
                              )
                          ),
                          child: Stepper(
                            controlsBuilder: (context,
                                { onStepContinue, onStepCancel}) {
                              return Column(
                                  children: <Widget>[
                                    SizedBox(height: 10,),
                                    Row(
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: onStepContinue,
                                          child: const Text('Siguiente'),
                                          style: TextButton.styleFrom(
                                            backgroundColor: mButtonColor,
                                            primary: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: onStepCancel,
                                          child: const Text('Atrás'),
                                        ),
                                      ],
                                    ),
                                  ]
                              );
                            },
                            steps:steps,
                            currentStep: currentStep,
                            onStepContinue: next,
                            onStepCancel: cancel,
                            onStepTapped: (step) => goTo(step),
                          ),
                        ),
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    _isKeyboardOpen ? Container() : CalculateButtonComponent(
                      buttonTitle: 'CALCULAR',
                      state: isNotValid(),
                      onTap: isNotValid() ? null :  () {
                        calculateFinalData();
                        Calculate calc = Calculate(finalData: totalResultado);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  puntaje: calc.calculateScore(),
                                  resultadoTexto: calc.getResult(),
                                  indicaciones: calc.getIndications(),
                                )));
                        //.then((value) => Navigator.popAndPushNamed(context, "/input"));
                    },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

