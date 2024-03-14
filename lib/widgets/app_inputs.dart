import 'package:flutter/material.dart';

//Input de tipo texto
class TextForms extends StatelessWidget {
  //variables ocupadas en cada vista (propiedades internas del widget)
  //Cabecera titulo
  final String? hintText;
  //Ayuda dentro del editor de texto
  final String? labelText;
  //Ayuda en la parte inferior del input
  final String? helperText;
  //tipo de teclado que se ejecutará
  final TextInputType? keyboardType;
  //te oculta el texto introducido sirve para passwords
  final bool obscureText;
  // habilita o deshabilita el input
  final bool enabled;
  //la cabecera del valor que obtendrá el json del formulario.
  final String formProperty;
  //el valor completo del objeto que se pasa al json del formulario
  final Map<String, dynamic> formValues;
  //función que se pasa a la vista para la ejecución de algun función especial
  final Function(dynamic)? fnSetState;
  final Function()? fnOnTabState;
  //validaciones que se integran a cada parametro necesario en el llenado del formulario
  final Function(dynamic)? fnValidator;
  //variable de tipo controller para la asignación de los valores
  final TextEditingController? controllerValue;
  //variable de tipo controller el cambio de teclado por ejemplo que el incial sea mayusculas .characters
  final TextCapitalization textCapitalization;
  //padding
  final double horizontal;
  final double vertical;
  //variable para el espacio final.
  final double horizontalSizedbox;
  final int maxLength;

  const TextForms({
    super.key,
    required this.formValues,
    required this.formProperty,
    this.hintText,
    this.labelText,
    this.fnSetState,
    this.fnOnTabState,
    this.textCapitalization = TextCapitalization.none,
    this.fnValidator,
    this.helperText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.horizontal = 8.0,
    this.vertical = 8.5,
    this.maxLength = -1,
    this.controllerValue,
    this.horizontalSizedbox = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Column(
          children: [
            TextFormField(
              //style: Theme.of(context).textTheme.displaySmall,
              controller: controllerValue,
              onChanged: (value) {
                formValues[formProperty] = value;
                //fnSetState(value);
                if (fnSetState != null) {
                  fnSetState!(value);
                }
              },
              onTap: () {
                if (fnOnTabState != null) {
                  fnOnTabState!();
                }
              },
              textCapitalization: textCapitalization,
              validator:
                  fnValidator == null ? null : (value) => fnValidator!(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: null,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                helperText: helperText,
                labelText: labelText,
                hintText: hintText,
                counter: const SizedBox.shrink(),
              ),
              keyboardType: keyboardType,
              maxLength: maxLength,
              obscureText: obscureText,
              enabled: enabled,
            ),
            SizedBox(
              height: horizontalSizedbox,
            )
          ],
        ),
      ),
    );
  }
}

//widget de input de tipo lista
class ListForms extends StatelessWidget {
  //Cabecera titulo
  final String? hintText;
  //Ayuda dentro del editor de texto
  final String? labelText;
  //Ayuda en la parte inferior del input
  final String? helperText;
  //valor asignado a la lista
  final String? selected;
  //parametros que obtiene la lista
  final List? list;
  //función que se pasa a la vista para ejecuciones especiales o extras
  final Function(String?) fnSetState;
  //la cabecera del valor que obtendrá el json del formulario.
  final String formProperty;
  final String dataProperty;
  //Nombre de la clave del arreglo en Json
  final String keyValue;
  final String keyChild;
  //el valor completo del objeto que se pasa al json del formulario
  final Map<String, dynamic> formValues;
  final Map<String, dynamic> dataValues;
  //validaciones que se integran a cada parametro necesario en el llenado del formulario
  final Function(dynamic)? fnValidator;
  final double horizontal;
  final double vertical;
  final double horizontalSizedbox;
  final bool enabled;

  const ListForms({
    super.key,
    required this.formValues,
    required this.dataValues,
    required this.formProperty,
    required this.dataProperty,
    this.hintText,
    this.labelText,
    this.helperText,
    required this.fnSetState,
    this.selected,
    required this.list,
    this.fnValidator,
    this.horizontal = 8.0,
    this.vertical = 8.5,
    this.keyValue = 'id',
    this.keyChild = 'datavalue',
    this.horizontalSizedbox = 16.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: selected, // Valor seleccionado
              decoration: InputDecoration(
                helperText: helperText,
                labelText: labelText,
                hintText: hintText,
              ),
              items: list?.map((data) {
                final String datavalue = data[keyValue].toString();
                final String datachild = data[keyChild];
                return DropdownMenuItem<String>(
                  value: datavalue,
                  child: Text(datachild),
                );
              }).toList(),
              onChanged: (value) async {
                Map<String, dynamic>? selectedNow;
                formValues[formProperty] = value;
                selectedNow = list!.firstWhere((data) => data['id'] == value);
                // Si dataValues es null, asigna el valor de formValues
                dataValues[dataProperty] = selectedNow![keyChild];
                if (value != null) {
                  var response = value;
                  fnSetState(response);
                }
              },
              validator:
                  fnValidator == null ? null : (value) => fnValidator!(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: horizontalSizedbox,
            )
          ],
        ),
      ),
    );
  }
}
