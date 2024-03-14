import 'package:fluent_ui/fluent_ui.dart';
import 'package:planeaciones/functions/functions.dart';
import 'package:planeaciones/models/objects.dart';
import 'package:planeaciones/widgets/widgets.dart';

List<Widget> generateListWidgets(
    List<dynamic> items,
    VoidCallback setStateCallback,
    Map<String, dynamic> formValues,
    Map<String, dynamic> pdfValues) {
  int cantidad = items.length;
  List<Widget> widgets = [];
  for (int i = 0; i < cantidad; i++) {
    if (!items[i]['boolean']) {
      formValues['eje$i'] = '';
      pdfValues['eje$i'] = '';
    }
    widgets.add(
      ListTile(
        onPressed: () {
          items[i]['boolean'] = !items[i]['boolean'];
          if (items[i]['boolean']) {
            formValues['eje$i'] = items[i]['id'];
            pdfValues['eje$i'] = items[i]['datavalue'];
          } else {
            formValues['eje$i'] = '';
            pdfValues['eje$i'] = '';
          }
          setStateCallback();
        },
        title: GestureDetector(
          onTap: () {
            items[i]['boolean'] = !items[i]['boolean'];
            if (items[i]['boolean']) {
              formValues['eje$i'] = items[i]['id'];
              pdfValues['eje$i'] = items[i]['datavalue'];
            } else {
              formValues['eje$i'] = '';
              pdfValues['eje$i'] = '';
            }
            setStateCallback();
          },
          child: TextMedium(
            textAlign: TextAlign.left,
            text: items[i]['datavalue'],
          ),
        ),
        leading: Checkbox(
          onChanged: (value) {
            items[i]['boolean'] = !items[i]['boolean'];
            if (items[i]['boolean']) {
              formValues['eje$i'] = items[i]['id'];
              pdfValues['eje$i'] = items[i]['datavalue'];
            } else {
              formValues['eje$i'] = '';
              pdfValues['eje$i'] = '';
            }
            setStateCallback();
          },
          checked: items[i]['boolean'],
        ),
      ),
    );
  }
  return widgets;
}

List<Widget> sessionsContent(
    int cantidad,
    DateTime? initDate,
    BuildContext context,
    List<TextEditingController> datesControllers,
    List<DateTime> datesDate,
    List<TextEditingController> beginningsControllers,
    List<TextEditingController> intermediatesControllers,
    List<TextEditingController> endingsControllers,
    List<TextEditingController> homeworksControllers,
    List<Map<String, dynamic>> sessionsValues) {
  List<Widget> widgets = [];
  int count;
  int staticAmount = datesControllers.length;
  print('create witgets $staticAmount, $cantidad');
  if (staticAmount > cantidad) {
    for (int i = cantidad; i < staticAmount; i++) {
      print('remove');
      datesControllers.removeAt(cantidad);
      datesDate.removeAt(cantidad);
      beginningsControllers.removeAt(cantidad);
      intermediatesControllers.removeAt(cantidad);
      endingsControllers.removeAt(cantidad);
      homeworksControllers.removeAt(cantidad);
      sessionsValues.removeAt(cantidad);
    }
  }
  print(datesControllers.length);
  for (int i = 0; i < cantidad; i++) {
    TextEditingController date = TextEditingController();
    TextEditingController beginningController = TextEditingController();
    TextEditingController intermediateController = TextEditingController();
    TextEditingController endingController = TextEditingController();
    TextEditingController homeworkController = TextEditingController();
    Map<String, dynamic> sessionValues = {};
    DateTime iDate;

    count = i + 1;
    print('Genetate witgets i= $i');
    //inicialización de primer fecha
    if (i == 0) {
      iDate = initDate!;
      date.text = initDate.toString().split(" ")[0];
    }
    //inialización de las demas fechas
    else {
      iDate = datesDate[i - 1].add(const Duration(days: 1));
      date.text = iDate.toString().split(" ")[0];
    }

    //agregar a las listas globales la misma cantidad de variables que el total de sesiones
    if (i >= staticAmount) {
      print('Add data');
      datesControllers.add(date);
      datesDate.add(iDate);
      beginningsControllers.add(beginningController);
      intermediatesControllers.add(intermediateController);
      endingsControllers.add(endingController);
      homeworksControllers.add(homeworkController);
      sessionsValues.add(sessionValues);
      sessionsValues[i]['date'] = date.text;
    } else {
      print('restabledata');
      datesControllers[i] = date;
      datesDate[i] = iDate;
      beginningsControllers[i].text = sessionsValues[i]['beginning'] ?? '';
      intermediatesControllers[i].text =
          sessionsValues[i]['intermediate'] ?? '';
      endingsControllers[i].text = sessionsValues[i]['ending'] ?? '';
      homeworksControllers[i].text = sessionsValues[i]['homework'] ?? '';
    }
    print('Cadena: $datesDate');
    widgets.add(
      SuperStandarCard(isTitle: false, content: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TextSubTitle(
                text: 'Sesión $count',
              ),
            ),
            Expanded(
              flex: 3,
              child: TextForms(
                labelText: 'Fecha',
                helperText: 'Elige la fecha de sesión',
                controllerValue: datesControllers[i],
                formProperty: 'date',
                formValues: sessionsValues[i],
                fnOnTabState: () async {
                  DateAndString result = await pickDate(context, datesDate[i]);
                  if (result.picked != null) {
                    print('Result:$result');
                    datesDate[i] = result.picked!;
                    String date = result.date;
                    int countNow = i + 1;
                    sessionsValues[i]['date'] = date;
                    for (countNow; countNow < cantidad; countNow++) {
                      print('forsetnewdate');
                      datesDate[countNow] =
                          datesDate[countNow - 1].add(const Duration(days: 1));
                      datesControllers[countNow].text =
                          datesDate[countNow].toString().split(" ")[0];
                      sessionsValues[countNow]['date'] =
                          datesControllers[countNow].text;
                    }
                    datesControllers[i].text = date;
                  }
                },
                fnValidator: (p0) {
                  bool isValid = RegExp(
                          r'^(\d{4})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$')
                      .hasMatch(p0);
                  if (p0 == '') {
                    return 'Este campo es requerido';
                  } else {
                    if (!isValid) {
                      return 'Debe tener formato YYYY-MM-DD';
                    } else {}
                  }
                },
              ),
            ),
            const Expanded(flex: 4, child: SizedBox()),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextForms(
                labelText: 'Inicio',
                hintText: 'Describe el inicio de tu sesión',
                helperText: 'Describe el inicio de tu sesión',
                controllerValue: beginningsControllers[i],
                formProperty: 'beginning',
                formValues: sessionsValues[i],
                fnValidator: (p0) {
                  if (p0 == '') {
                    return 'Este campo es requerido';
                  }
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: TextForms(
                labelText: 'Desarrollo',
                hintText: 'Describe el desarrollo de tu sesión',
                helperText: 'Describe el desarrollo de tu sesión',
                controllerValue: intermediatesControllers[i],
                formProperty: 'intermediate',
                formValues: sessionsValues[i],
                fnValidator: (p0) {
                  if (p0 == '') {
                    return 'Este campo es requerido';
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextForms(
                labelText: 'Cierre',
                hintText: 'Describe el cierre de tu sesión',
                helperText: 'Describe el cierre de tu sesión',
                controllerValue: endingsControllers[i],
                formProperty: 'ending',
                formValues: sessionsValues[i],
                fnValidator: (p0) {
                  if (p0 == '') {
                    return 'Este campo es requerido';
                  }
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: TextForms(
                labelText: 'Tarea',
                hintText: '¿Cúal es la tarea de la sesión?',
                helperText: '¿Cúal es la tarea de la sesión?',
                controllerValue: homeworksControllers[i],
                formProperty: 'homework',
                formValues: sessionsValues[i],
              ),
            ),
          ],
        ),
      ]),
    );
  }
  return widgets;
}

List<Widget> pdaContent(
    int numContent,
    int cantidad,
    List<dynamic> documentList,
    void Function(int) setStateCallback,
    Map<String, dynamic> formsValues,
    Map<String, dynamic> pdfsValues) {
  List<Widget> currentRow = [];
  List<Widget> widgets = [];
  String nameDocument;
  //bool check;
  widgets.add(
    const TextSubTitle(
      styletext: false,
      text: 'Procesos de desarrollo de aprendizajes \n PDA',
    ),
  );
  for (int i = 0; i < cantidad; i++) {
    Map<String, dynamic> mapDocument = {};
    nameDocument = documentList[i]['datavalue'];
    mapDocument['namedocument'] = nameDocument;
    if (!documentList[i]['boolean']) {
      formsValues['pda$i'] = '';
      pdfsValues['pda$i'] = '';
    }
    currentRow.add(
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListTile(
            onPressed: () {
              documentList[i]['boolean'] = !documentList[i]['boolean'];
              if (documentList[i]['boolean']) {
                formsValues['pda$i'] = documentList[i]['id'];
                pdfsValues['pda$i'] = documentList[i]['datavalue'];
              } else {
                formsValues['pda$i'] = '';
                pdfsValues['pda$i'] = '';
              }
              setStateCallback(numContent);
            },
            title: GestureDetector(
              onTap: () {
                documentList[i]['boolean'] = !documentList[i]['boolean'];
                if (documentList[i]['boolean']) {
                  formsValues['pda$i'] = documentList[i]['id'];
                  pdfsValues['pda$i'] = documentList[i]['datavalue'];
                } else {
                  formsValues['pda$i'] = '';
                  pdfsValues['pda$i'] = '';
                }
                setStateCallback(numContent);
              },
              child: TextMedium(
                textAlign: TextAlign.start,
                text: nameDocument,
              ),
            ),
            leading: Checkbox(
              onChanged: (value) {
                documentList[i]['boolean'] = !documentList[i]['boolean'];
                if (documentList[i]['boolean']) {
                  formsValues['pda$i'] = documentList[i]['id'];
                  pdfsValues['pda$i'] = documentList[i]['datavalue'];
                } else {
                  formsValues['pda$i'] = '';
                  pdfsValues['pda$i'] = '';
                }
                setStateCallback(numContent);
              },
              checked: documentList[i]['boolean'],
            ),
          ),
        ),
      ),
    );
    // Si la fila actual alcanza el máximo de 3 widgets o es el último elemento, agregar la fila a la lista de widgets
    if (currentRow.length == 3 || i == cantidad - 1) {
      // Agregar fila actual a la lista de widgets
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [...currentRow],
          ),
        ),
      );
      if (i != cantidad - 1) {
        widgets.add(const SizedBox(height: 10)); // Espacio vertical entre filas
      }
      // Limpiar la fila actual para la siguiente fila
      currentRow = [];
    }
  }
  //print(formValues);
  return widgets;
}
