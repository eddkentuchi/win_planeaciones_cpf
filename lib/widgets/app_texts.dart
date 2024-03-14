//-------Todos widgets de texto personalizado-------//
//Texto normal
import 'package:flutter/material.dart';

TextStyle styleSmall = const TextStyle(fontSize: 8);
TextStyle styleMedium = const TextStyle(fontSize: 12);
TextStyle styleSubTitle = const TextStyle(fontSize: 24);
TextStyle styleTitle = const TextStyle(fontSize: 28);

class TextSmall extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool styletext;
  final EdgeInsetsGeometry padding;

  const TextSmall({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.styletext = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        //metodo de llamado de tipo de letra
        style: styletext ? styleSmall : styleSmall,
      ),
    );
  }
}

//Texto medio
class TextMedium extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool styletext;
  const TextMedium({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.styletext = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: styletext ? styleMedium : styleMedium,
    );
  }
}

//Texto Subtitulo
class TextSubTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool styletext;
  const TextSubTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.styletext = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        textAlign: textAlign,
        style: styletext ? styleSubTitle : styleSubTitle,
      ),
    );
  }
}

//Texto titulo
class TextTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final bool styletext;
  const TextTitle({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.styletext = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        textAlign: textAlign,
        style: styletext ? styleTitle : styleTitle,
      ),
    );
  }
}
