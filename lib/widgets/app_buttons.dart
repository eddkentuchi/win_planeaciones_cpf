import 'package:flutter/material.dart';

class ButtonLargeGreen extends StatelessWidget {
  final double
      horizontal; //Es la distancia en horizontal que tiene el boton con respecto al Scaffold
  final double
      vertical; //Es la distancia en vertical que tiene el boton con respecto al Scaffold
  final String?
      bottonText; //Es el texto estandar que tiene el widget por defecto
  final Function() fnSetState; //Funcionalidad
  final double largebutton;
  final double sizeletter;
  final double widthbutton;
  final TextAlign alignbutton;

  const ButtonLargeGreen({
    this.horizontal = 24.0,
    this.vertical = 8.0,
    this.bottonText = ("Soy un Elevated Button"),
    this.sizeletter = 16,
    this.largebutton = 48,
    this.alignbutton = TextAlign.center,
    this.widthbutton = double.infinity,
    Key? key,
    required this.fnSetState,
  }) : super(key: key);

  //Aquí se contruye el widget del ElevatedButton verde.

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: SizedBox(
          width: widthbutton,
          height: largebutton,
          child: ElevatedButton(
            onPressed: () {
              fnSetState();
            },
            child: Center(
              child: Text(bottonText!,
                  textAlign: alignbutton,
                  style: TextStyle(fontSize: sizeletter)),
            ),
          ),
        ),
      ),
    );
  }
}
