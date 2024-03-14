import 'package:flutter/material.dart';
import 'package:planeaciones/functions/functions.dart';
import 'package:planeaciones/theme/app_theme.dart';
import 'package:planeaciones/widgets/widgets.dart';

class SuperStandarCard extends StatelessWidget {
  final double horizontalMargin; //Margen horizontal de la card a el Scafold
  final double verticalMargin; //Margen vertical de la card a el Scafold
  final List<Widget> content; // Todos los widgets que va a contener mi card
  final Color? color; // Color del fondo
  final double horizontalPadding; //Margen horizontal del pading interno
  final double verticalPadding; //Margen vertical del pading interno
  final double floatButtonPadding; // padding interno
  final bool visible; // visibilidad de boton
  final String? title;
  final bool isTitle;
  const SuperStandarCard({
    super.key,
    this.horizontalMargin = 0,
    this.verticalMargin = 8.0,
    this.color,
    required this.content,
    this.visible = false,
    this.horizontalPadding = 16,
    this.verticalPadding = 18,
    this.floatButtonPadding = 12,
    this.title,
    this.isTitle = true,
  });

//Aquí se contruye los popit con margen de color.

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getColor(isTitle, context),
      margin: EdgeInsets.symmetric(
          vertical: verticalMargin, horizontal: horizontalMargin),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding, horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: visible,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: FloatingActionButton(
                            backgroundColor:
                                AppFluentTheme.appPrimaryColor['normal'],
                            child: const Icon(
                              Icons.close_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Cerrar el diálogo
                            },
                          ),
                        ),
                        SizedBox(
                          height: floatButtonPadding,
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: title != null,
                    child: TextTitle(
                      textAlign: TextAlign.left,
                      styletext: false,
                      text: title ?? '',
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: content,
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class SuperExpanded extends StatelessWidget {
  final List<Widget> content; // Todos los widgets que va a contener mi card
  final double horizontalPadding; //Margen horizontal del pading interno
  final double verticalPadding; //Margen vertical del pading interno
  final double floatButtonPadding; // padding interno
  final bool visible; // visibilidad de boton
  final String? title;
  final bool isTitle;
  const SuperExpanded({
    Key? key,
    required this.content,
    this.visible = false,
    this.horizontalPadding = 16,
    this.verticalPadding = 18,
    this.floatButtonPadding = 12,
    this.title,
    this.isTitle = true,
  }) : super(key: key);

//Aquí se contruye los popit con margen de color.

  @override
  Widget build(BuildContext context) {
    return const Text('eaderBuilder, body: body');
    //Expander(
    //  header: Visibility(
    //    visible: title != null,
    //    child: TextTitle(
    //      textAlign: TextAlign.left,
    //      styletext: false,
    //      text: title ?? '',
    //    ),
    //  ),
    //  contentBackgroundColor: getColor(isTitle, context),
    //  content: Column(
    //    children: [
    //      Padding(
    //          padding: EdgeInsets.symmetric(
    //              vertical: verticalPadding, horizontal: horizontalPadding),
    //          child: Column(
    //              crossAxisAlignment: CrossAxisAlignment.stretch,
    //              children: content)),
    //    ],
    //  ),
    //);
  }
}
