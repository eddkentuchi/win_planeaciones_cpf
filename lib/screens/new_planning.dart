import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart' show ScaffoldPage;
import 'package:planeaciones/connections/connections.dart';
import 'package:planeaciones/functions/functions.dart';
import 'package:planeaciones/models/objects.dart';
import 'package:planeaciones/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class Planning extends StatefulWidget {
  const Planning({Key? key}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  //listas de busqueda total
  List<dynamic>? teachers = [
    {
      'id': '1',
      'name': 'Maestro1',
      'grade': '1',
      'idgrade': '4',
      'grup': 'A',
      'phase': '3',
      'idphase': '3'
    },
    {
      'id': '2',
      'name': 'Maestro2',
      'grade': '2',
      'idgrade': '5',
      'grup': 'A',
      'phase': '3',
      'idphase': '3'
    },
    {
      'id': '3',
      'name': 'Maestro3',
      'grade': '3',
      'idgrade': '6',
      'grup': 'A',
      'phase': '4',
      'idphase': '4'
    },
    {
      'id': '4',
      'name': 'Maestro4',
      'grade': '4',
      'idgrade': '7',
      'grup': 'A',
      'phase': '4',
      'idphase': '4'
    },
    {
      'id': '5',
      'name': 'Maestro5',
      'grade': '5',
      'idgrade': '8',
      'grup': 'A',
      'phase': '5',
      'idphase': '5'
    },
    {
      'id': '6',
      'name': 'Maestro6',
      'grade': '6',
      'idgrade': '9',
      'grup': 'A',
      'phase': '5',
      'idphase': '5'
    },
  ];
  List<dynamic>? problems = [
    {'id': '1', 'datavalue': 'Problema 1'},
    {'id': '2', 'datavalue': 'Problema 2'},
    {'id': '3', 'datavalue': 'Problema 3'},
  ];
  List<dynamic>? methodologies = [
    {'id': '1', 'datavalue': 'Metodologia 1'},
    {'id': '2', 'datavalue': 'Metodologia 2'},
    {'id': '3', 'datavalue': 'Metodologia 3'},
  ];
  List<dynamic>? numberFormative = [
    {'id': '1', 'datavalue': '1'},
    {'id': '2', 'datavalue': '2'},
    {'id': '3', 'datavalue': '3'},
    {'id': '4', 'datavalue': '4'},
  ];
  List<dynamic>? formatives = [
    {'id': '1', 'datavalue': 'Lenguajes', 'image': 'CFL.png'},
    {
      'id': '2',
      'datavalue': 'Saberes y Pensamiento Cientifico',
      'image': 'CFSyPC.png'
    },
    {
      'id': '3',
      'datavalue': 'De lo Humano y lo Comunitario',
      'image': 'CFHyC.png'
    },
    {
      'id': '4',
      'datavalue': 'Ética, Naturaleza y Sociedades',
      'image': 'CFENyS.png'
    },
  ];
  List<dynamic> articulatingAxis = [
    {'datavalue': 'Opción 1', 'boolean': false, 'id': '1'},
    {'datavalue': 'Opción 2', 'boolean': false, 'id': '2'},
    {'datavalue': 'Opción 3', 'boolean': false, 'id': '3'},
    {'datavalue': 'Opción 4', 'boolean': false, 'id': '4'},
    {'datavalue': 'Opción 5', 'boolean': false, 'id': '5'},
    {'datavalue': 'Opción 6', 'boolean': false, 'id': '6'},
    {'datavalue': 'Opción 7', 'boolean': false, 'id': '7'},
  ];

  //busqueda por grado
  List<dynamic>? books = [
    {'id': '1', 'datavalue': 'Libro 1'},
    {'id': '2', 'datavalue': 'Libro 2'},
    {'id': '3', 'datavalue': 'Libro 3'},
  ];
  //busqueda por libros
  List<dynamic>? proyects = [
    {'id': '1', 'datavalue': 'Proyecto 1'},
    {'id': '2', 'datavalue': 'Proyecto 2'},
    {'id': '3', 'datavalue': 'Proyecto 3'},
  ];
  //busqueda por campos formativos
  List<List<dynamic>?> evercontents = [];
  //busqueda por contenidos
  List<List<dynamic>?> pdaLists = [];

  //--Mapas de datos obtenidos--//
  final Map<String, dynamic> formValues = {};
  final Map<String, dynamic> pdfValues = {};
  //campos formativos
  List<Map<String, dynamic>> formsValues = [];
  List<Map<String, dynamic>> pdfsValues = [];
  //sessions values
  List<Map<String, dynamic>> sessionsValues = [];
  //----//
  //llave para la validación de mis formularios
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  //lista donde seguardan los widget de las funciones
  List<List<Widget>> pdaGenerados = [];
  List<Widget> sessionsGenerated = [];
  List<Widget> formativesGenerated = [];
  List<Widget> listWidgets = [];
  //Dato que optiene el numero de pda generales
  int numberOfPDA = 0;
  int? numberOfSesion;
  String? selectedTeacherId;
  Map<String, dynamic>? selectedTeacher;
  //section of group
  TextEditingController gradeController = TextEditingController();
  TextEditingController grupController = TextEditingController();
  TextEditingController phaseController = TextEditingController();
  //section of proyects
  //section of formative fields
  bool sessionVisible = false;
  List<bool> contPdasVisible = [];
  //section of temporality
  DateTime? initDate;
  DateTime? finalDate;
  TextEditingController initDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();
  TextEditingController sessionsController = TextEditingController();
  //section of sessions
  List<TextEditingController> datesControllers = [];
  List<DateTime> datesDate = [];
  List<TextEditingController> beginningsControllers = [];
  List<TextEditingController> intermediatesControllers = [];
  List<TextEditingController> endingsControllers = [];
  List<TextEditingController> homeworksControllers = [];
  //fin de varialbles

//TODO: add bools to selects PDA
  List<Widget> formativesWitgets(int cantidad) {
    List<Widget> widgets = [];
    int count;
    int staticAmount = formsValues.length;
    print('create witgets $staticAmount, $cantidad');
    if (staticAmount > cantidad) {
      for (int i = cantidad; i < staticAmount; i++) {
        print('remove');
        pdaGenerados.removeAt(cantidad);
        contPdasVisible.removeAt(cantidad);
        formsValues.removeAt(cantidad);
        pdfsValues.removeAt(cantidad);
        pdaLists.removeAt(cantidad);
        evercontents.removeAt(cantidad);
      }
    }
    print(
        '\nLista boleanos: $contPdasVisible\nLista widgets pda: $pdaGenerados\nLista formsValues: $formsValues\nLista pdfsValues: $pdfsValues');
    for (int i = 0; i < cantidad; i++) {
      List<dynamic>? pdaList = [];
      List<dynamic>? contents = [];
      List<Widget>? contentPda = [];
      bool pdaVisible = false;
      Map<String, dynamic> formValue = {};
      Map<String, dynamic> pdfValue = {};
      //String selectedcontent = null;
      //print(pdaGenerados.length);
      if (cantidad > pdaGenerados.length) {
        print('add');
        pdaGenerados.add(contentPda);
        contPdasVisible.add(pdaVisible);
        formsValues.add(formValue);
        pdfsValues.add(pdfValue);
        pdaLists.add(pdaList);
        evercontents.add(contents);
      }
      count = i + 1;
      widgets.add(
        SuperStandarCard(isTitle: false, content: [
          ListForms(
            labelText: 'Campo formativo',
            helperText: 'Selecciona el campo formativo a desarrollar',
            list: formatives,
            formProperty: 'idformative$count',
            dataProperty: 'formative$count',
            dataValues: pdfsValues[i],
            formValues: formsValues[i],
            fnSetState: (value) async {
              Stopwatch stopwatch = Stopwatch()..start();
              contPdasVisible[i] = false;
              fContents(formsValues[i], i + 1, formValues, stopwatch)
                  .then((value) {
                //print('value fContents:$value');
                print(
                    'Tiempo fin de busqueda: ${stopwatch.elapsedMilliseconds} ms');
                print(value[0]['datavalue']);
                if (value != null) {
                  int j = i + 1;
                  evercontents[i]?.clear();
                  evercontents[i]?.addAll(value);
                  formsValues[i]['idcontent$j'] = null;
                  print("jelow");
                  if (formsValues[i]['idcontent$j'] == null) {
                    setState(() {
                      formativesGenerated = formativesWitgets(
                          int.tryParse(formValues['numberFormative'])!);
                      stopwatch.stop();
                      print(
                          'Tiempo total: ${stopwatch.elapsedMilliseconds} ms');
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'alert');
                }
              });

              print(
                  'Tiempo buble principal: ${stopwatch.elapsedMilliseconds} ms');
            },
            fnValidator: (p0) {
              if (p0 == null) {
                return 'Este campo es requerido';
              }
            },
          ),
          ListForms(
            labelText: 'Contenido',
            helperText: 'Selecciona el contenido a trabajar',
            list: evercontents[i],
            selected: formsValues[i]['idcontent$count'],
            formProperty: 'idcontent$count',
            dataProperty: 'content$count',
            dataValues: pdfsValues[i],
            formValues: formsValues[i],
            fnSetState: (value) async {
              print('jeloS');
              fpdas(formsValues[i], i + 1, formValues).then((value) {
                print(value);
                if (value != null) {
                  pdaLists[i]?.clear();
                  pdaLists[i]?.addAll(value);
                  numberOfPDA = pdaLists[i]!.length;
                  setState(() {
                    contPdasVisible[i] = true;
                    if (numberOfPDA != 0) {
                      List<String> keysToRemove = [];
                      print('i:$i\nformsValues:$formsValues');
                      for (var key in formsValues[i].keys) {
                        if (key.startsWith('pda')) {
                          keysToRemove.add(key);
                        }
                      }
                      if (keysToRemove.isNotEmpty) {
                        for (var key in keysToRemove) {
                          formsValues[i].remove(key);
                          pdfsValues[i].remove(key);
                        }
                      } else {
                        print(
                            'No hay elementos con clave que comience con "idpda"');
                      }
                      pdaGenerados[i] = pdaContent(
                          i,
                          numberOfPDA,
                          pdaLists[i] as List<dynamic>,
                          pdastatus,
                          formsValues[i],
                          pdfsValues[i]);
                    } else {
                      pdaGenerados[i] = [const Text('nada')];
                    }
                    formativesGenerated = formativesWitgets(
                        int.tryParse(formValues['numberFormative'])!);
                  });
                } else {
                  Navigator.pushNamed(context, 'alert');
                }
              });

              setState(() {});
            },
            fnValidator: (p0) {
              if (p0 == null) {
                return 'Este campo es requerido';
              }
            },
          ),
          Visibility(
            visible: contPdasVisible[i],
            child: SuperStandarCard(
              isTitle: true,
              content: [
                ...pdaGenerados[i],
              ],
            ),
          ),
        ]),
      );
    }
    return widgets;
  }

  //
  void ejesarticuladores() {
    setState(() {
      listWidgets = generateListWidgets(
          articulatingAxis, ejesarticuladores, formValues, pdfValues);
    });
  }

  void pdastatus(int i) {
    setState(() {
      //pdaLists[0]![i]['boolean'] = !pdaLists[0]![i]['boolean'];
      print(pdaLists[i]);

      pdaGenerados[i] = pdaContent(i, numberOfPDA, pdaLists[i] as List<dynamic>,
          pdastatus, formsValues[i], pdfsValues[i]);
      formativesGenerated =
          formativesWitgets(int.tryParse(formValues['numberFormative'])!);
    });
  }

  @override
  void initState() {
    formValues['numberFormative'] = numberFormative![0]['datavalue'];
    setState(() {
      listWidgets = generateListWidgets(
          articulatingAxis, ejesarticuladores, formValues, pdfValues);
      if (int.tryParse(formValues['numberFormative'])! > 0) {
        //sessionVisible = true;
        formativesGenerated =
            formativesWitgets(int.tryParse(formValues['numberFormative'])!);
      } else {
        //sessionVisible = false;
        formativesGenerated = [const Text('')];
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: Form(
          key: myFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                //grupo
                SuperStandarCard(title: 'Grupo', content: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        //docente
                        child: ListForms(
                          keyChild: 'name',
                          labelText: 'Docente',
                          helperText: 'Selecciona al docente',
                          list: teachers,
                          formProperty: 'idNameTeacher',
                          dataProperty: 'nameTeacher',
                          dataValues: pdfValues,
                          formValues: formValues,
                          fnSetState: (value) async {
                            selectedTeacherId = value;
                            selectedTeacher = teachers!.firstWhere(
                                (teacher) => teacher['id'] == value);
                            formValues['idphase'] = selectedTeacher!['idphase'];
                            formValues['idgrade'] = selectedTeacher!['idgrade'];
                            pdfValues['grade'] = selectedTeacher!['grade'];
                            pdfValues['grup'] = selectedTeacher!['grup'];
                            pdfValues['phase'] = selectedTeacher!['phase'];
                            setState(() {
                              gradeController.text = selectedTeacher!['grade'];
                              grupController.text = selectedTeacher!['grup'];
                              phaseController.text = selectedTeacher!['phase'];
                            });
                          },
                          fnValidator: (p0) {
                            if (p0 == null) {
                              return 'Este campo es requerido';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        //grado
                        child: TextForms(
                          enabled: false,
                          labelText: 'Grado',
                          helperText: 'Grado asignado',
                          controllerValue: gradeController,
                          fnSetState: (value) async {},
                          formProperty: 'grade',
                          formValues: formValues,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        //grupo
                        child: TextForms(
                          enabled: false,
                          labelText: 'Grupo',
                          helperText: 'Grupo asignado',
                          controllerValue: grupController,
                          fnSetState: (value) async {},
                          formProperty: 'grup',
                          formValues: formValues,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextForms(
                          enabled: false,
                          labelText: 'Fase',
                          helperText: 'Fase del grado',
                          controllerValue: phaseController,
                          fnSetState: (value) async {},
                          formProperty: 'phase',
                          formValues: formValues,
                        ),
                      ),
                    ],
                  ),
                  ListForms(
                    labelText: 'Problematica',
                    helperText: 'Selecciona la problematica',
                    list: problems,
                    formProperty: 'problem',
                    dataProperty: 'problem',
                    dataValues: pdfValues,
                    formValues: formValues,
                    fnSetState: (value) async {},
                    fnValidator: (p0) {
                      if (p0 == null) {
                        return 'Este campo es requerido';
                      }
                    },
                  ),
                ]),
                //proyecto
                SuperStandarCard(title: 'Proyecto', content: [
                  Row(children: [
                    Expanded(
                      flex: 4,
                      child: ListForms(
                        labelText: 'Nombre del libro',
                        helperText: 'Selecciona el libro de texto',
                        list: books,
                        formProperty: 'idBook',
                        dataProperty: 'book',
                        dataValues: pdfValues,
                        formValues: formValues,
                        fnSetState: (value) async {},
                        fnValidator: (p0) {
                          if (p0 == null) {
                            return 'Este campo es requerido';
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: ListForms(
                        labelText: 'Nombre del proyecto',
                        helperText: 'Selecciona el proyecto',
                        list: proyects,
                        formProperty: 'proyect',
                        dataProperty: 'proyect',
                        dataValues: pdfValues,
                        formValues: formValues,
                        fnSetState: (value) async {},
                        fnValidator: (p0) {
                          if (p0 == null) {
                            return 'Este campo es requerido';
                          }
                        },
                      ),
                    ),
                  ]),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SuperStandarCard(
                                  isTitle: false,
                                  horizontalMargin: 12,
                                  content: [
                                    const TextSubTitle(
                                        text: 'Ejes Articuladores'),
                                    ...listWidgets,
                                  ]),
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Column(
                                children: [
                                  ListForms(
                                    labelText: 'Metodologia',
                                    helperText: 'Selecciona la metodologia',
                                    list: methodologies,
                                    formProperty: 'methodology',
                                    dataProperty: 'methodology',
                                    dataValues: pdfValues,
                                    formValues: formValues,
                                    fnSetState: (value) async {},
                                    fnValidator: (p0) {
                                      if (p0 == null) {
                                        return 'Este campo es requerido';
                                      }
                                    },
                                  ),
                                  TextForms(
                                    labelText: 'Propósito',
                                    hintText:
                                        'Escribe el propósito del proyecto',
                                    helperText:
                                        'Escribe el propósito del proyecto',
                                    formValues: formValues,
                                    formProperty: 'purpose',
                                    fnSetState: (value) async {
                                      pdfValues['purpose'] = value;
                                    },
                                    fnValidator: (p0) {
                                      if (p0 == '') {
                                        return 'Este campo es requerido';
                                      }
                                    },
                                  ),
                                  TextForms(
                                    labelText: 'Producto',
                                    hintText:
                                        'Escribe el producto del proyecto',
                                    helperText:
                                        'Escribe el producto del proyecto',
                                    formValues: formValues,
                                    formProperty: 'product',
                                    fnSetState: (value) async {
                                      pdfValues['product'] = value;
                                    },
                                    fnValidator: (p0) {
                                      if (p0 == '') {
                                        return 'Este campo es requerido';
                                      }
                                    },
                                  ),
                                  TextForms(
                                    labelText: 'Codiseño',
                                    helperText:
                                        'Describe el codiseño del proyecto',
                                    formValues: formValues,
                                    formProperty: 'design',
                                    fnSetState: (value) async {
                                      pdfValues['design'] = value;
                                    },
                                    fnValidator: (p0) {
                                      if (p0 == '') {
                                        return 'Este campo es requerido';
                                      }
                                    },
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
                //campo formativo
                SuperStandarCard(title: 'Contenido', content: [
                  ListForms(
                    labelText: 'Número de campos formativos',
                    helperText:
                        'Si hay transversalidad de campos formativos selecciona mas de uno',
                    list: numberFormative,
                    selected: numberFormative![0]['datavalue'],
                    formProperty: 'numberFormative',
                    dataProperty: 'numberFormative',
                    dataValues: pdfValues,
                    formValues: formValues,
                    fnSetState: (value) async {
                      //TODO: Resetear las listas de informaciónque muestra
                      setState(() {
                        if (int.tryParse(formValues['numberFormative'])! > 0) {
                          //sessionVisible = true;
                          formativesGenerated = formativesWitgets(
                              int.tryParse(formValues['numberFormative'])!);
                        } else {
                          //sessionVisible = false;
                          formativesGenerated = [const Text('')];
                        }
                      });
                    },
                    fnValidator: (p0) {
                      if (p0 == null) {
                        return 'Este campo es requerido';
                      }
                    },
                  ),
                  ...formativesGenerated,
                ]),
                //Temporalidad
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SuperStandarCard(title: 'Temporalidad', content: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          //fecha inicio
                          child: TextForms(
                            labelText: 'Fecha Inicio',
                            helperText: 'Ingresa fecha inicial del proyecto',
                            controllerValue: initDateController,
                            formValues: formValues,
                            formProperty: 'dateinit',
                            fnOnTabState: () async {
                              DateAndString result = await pickDate(
                                  context,
                                  finalDate != null
                                      ? finalDate!
                                          .add(const Duration(days: -11))
                                      : DateTime.now());
                              initDate = result.picked;
                              String date = result.date;
                              int weekdaysBetween = 0;
                              if (initDate != null && finalDate != null) {
                                if (initDate!.isBefore(finalDate!)) {
                                  DateTime current = initDate!;
                                  while (current.isBefore(finalDate!) ||
                                      current == finalDate) {
                                    if (current.weekday != DateTime.saturday &&
                                        current.weekday != DateTime.sunday) {
                                      weekdaysBetween++;
                                    }
                                    current =
                                        current.add(const Duration(days: 1));
                                  }
                                }
                              }
                              setState(() {
                                initDateController.text = date;
                                sessionsController.text =
                                    weekdaysBetween.toString();
                                formValues['sessions'] =
                                    weekdaysBetween.toString();
                                pdfValues['sessions'] =
                                    weekdaysBetween.toString();
                                formValues['dateinit'] = date;
                                pdfValues['dateinit'] = date;
                              });
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
                                } else {
                                  if (initDate != null && finalDate != null) {
                                    if (initDate!.isAfter(finalDate!)) {
                                      return 'Debe ser menor a Fecha Fin';
                                    }
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          //fecha fin
                          child: TextForms(
                            labelText: 'Fecha Fin',
                            helperText: 'Ingresa fecha de termino del proyecto',
                            controllerValue: finishDateController,
                            formValues: formValues,
                            formProperty: 'datefinish',
                            fnOnTabState: () async {
                              DateAndString result = await pickDate(
                                  context,
                                  initDate != null
                                      ? initDate!.add(const Duration(days: 11))
                                      : DateTime.now());
                              finalDate = result.picked;
                              String date = result.date;
                              int weekdaysBetween = 0;
                              if (initDate != null && finalDate != null) {
                                if (initDate!.isBefore(finalDate!)) {
                                  DateTime current = initDate!;
                                  while (current.isBefore(finalDate!) ||
                                      current == finalDate) {
                                    if (current.weekday != DateTime.saturday &&
                                        current.weekday != DateTime.sunday) {
                                      weekdaysBetween++;
                                    }
                                    current =
                                        current.add(const Duration(days: 1));
                                  }
                                }
                              }
                              setState(() {
                                finishDateController.text = date;
                                sessionsController.text =
                                    weekdaysBetween.toString();
                                formValues['sessions'] =
                                    weekdaysBetween.toString();
                                pdfValues['sessions'] =
                                    weekdaysBetween.toString();
                                formValues['datefinish'] = date;
                                pdfValues['datefinish'] = date;
                                numberOfSesion = weekdaysBetween;
                                if (numberOfSesion! > 0) {
                                  sessionVisible = true;
                                  sessionsGenerated = sessionsContent(
                                      numberOfSesion!,
                                      initDate,
                                      context,
                                      datesControllers,
                                      datesDate,
                                      beginningsControllers,
                                      intermediatesControllers,
                                      endingsControllers,
                                      homeworksControllers,
                                      sessionsValues);
                                } else {
                                  sessionVisible = false;
                                  sessionsGenerated = [const Text('')];
                                }
                              });
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
                                } else {
                                  if (initDate != null && finalDate != null) {
                                    if (initDate!.isAfter(finalDate!)) {
                                      return 'Debe ser mayor a Fecha Incio';
                                    }
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          //Sesiones
                          child: TextForms(
                            labelText: 'Sesiones',
                            helperText: 'Escribe el número de sesiones',
                            controllerValue: sessionsController,
                            formProperty: 'sessions',
                            formValues: formValues,
                            fnSetState: (value) async {
                              int? intValue = int.tryParse(value);
                              if (intValue != null) {
                                if (intValue <= 20 && intValue > 2) {
                                  setState(() {
                                    sessionsController.text = value;
                                    numberOfSesion = intValue;
                                    if (numberOfSesion! > 0) {
                                      pdfValues['sessions'] = value;
                                      sessionVisible = true;
                                      sessionsGenerated = sessionsContent(
                                          numberOfSesion!,
                                          initDate,
                                          context,
                                          datesControllers,
                                          datesDate,
                                          beginningsControllers,
                                          intermediatesControllers,
                                          endingsControllers,
                                          homeworksControllers,
                                          sessionsValues);
                                    } else {
                                      sessionVisible = false;
                                      sessionsGenerated = [const Text('')];
                                      pdfValues['sessions'] =
                                          formValues['sessions'];
                                    }
                                  });
                                }
                              }
                            },
                            fnValidator: (p0) {
                              int? intValue = int.tryParse(p0);
                              if (p0 == '') {
                                return 'Este campo es requerido';
                              }
                              if (intValue == null) {
                                return 'Debe ser un número';
                              }
                              if (intValue > 20) {
                                return 'Debe ser menor que 20';
                              }
                              if (intValue <= 2) {
                                return 'Debe ser mayor que 2';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                //Sesiones
                Visibility(
                  visible: sessionVisible,
                  child: SuperStandarCard(
                    title: 'Secuencia de actividades',
                    content: [
                      ...sessionsGenerated,
                    ],
                  ),
                ),
                //Botones
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ButtonLargeGreen(
                        bottonText: ("Guardar"),
                        horizontal: 8,
                        fnSetState: () async {
                          print(
                              '\nformValues:$formValues\npdfValues:$pdfValues\nsessionsValues:$sessionsValues\nformsValues:$formsValues\npdfsValues:$pdfsValues');
                          await firstConeccion();
                          if (!myFormKey.currentState!.validate()) {
                            debugPrint('Formulario no valido');
                            return;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ButtonLargeGreen(
                        bottonText: ("Generar PDF"),
                        horizontal: 8,
                        fnSetState: () {
                          plannigpdf();
                          //if (!myFormKey.currentState!.validate()) {
                          //  debugPrint('Formulario no valido');
                          //  return;
                          //}
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> plannigpdf() async {
    //Configuración de documento tamaño de hoja orientación y variables de documento
    String phase = '';
    String group = '';
    String nameTeacher = '';
    String sessions = '';
    String date = '';
    String nameproyect = '';
    String book = '';
    String problem = '';
    String methodology = '';
    String purpose = '';
    String product = '';
    String design = '';
    String ejes = '';
    try {
      String dateSInit = pdfValues['dateinit'];
      String dateSFinish = pdfValues['datefinish'];
      DateTime parsedDateInit = DateTime.parse(dateSInit);
      DateTime parsedDateFinish = DateTime.parse(dateSFinish);
      phase = 'Fase: ${pdfValues['phase']}';
      group = 'Grado: ${pdfValues['grade']} ';
      nameTeacher = 'Docente: ${pdfValues['nameTeacher']}';
      sessions = ' ${pdfValues['sessions']} Sesiones';

      if (parsedDateInit.year == parsedDateFinish.year) {
        if (parsedDateInit.month == parsedDateFinish.month) {
          date =
              'Del ${parsedDateInit.day} al ${parsedDateFinish.day} de ${getMonthName(parsedDateInit.month)} del ${parsedDateInit.year}';
        } else {
          date =
              'Del ${parsedDateInit.day} de ${getMonthName(parsedDateInit.month)} al ${parsedDateFinish.day} de ${getMonthName(parsedDateFinish.month)} del ${parsedDateInit.year}';
        }
      } else {
        date =
            'Del ${parsedDateInit.day} de ${getMonthName(parsedDateInit.month)} del ${parsedDateInit.year} al ${parsedDateFinish.day} de ${getMonthName(parsedDateFinish.month)} del ${parsedDateFinish.year}';
      }
      nameproyect = pdfValues['proyect'];
      book = pdfValues['book'];
      problem = pdfValues['problem'];
      methodology = pdfValues['methodology'];
      purpose = pdfValues['purpose'];
      product = pdfValues['product'];
      design = pdfValues['design'];
      ejes = concatenarValores(pdfValues, 'eje');
    } catch (e) {
      print('Se produjo una excepción en data1: $e');
    }

    List<dynamic>? data1 = [
      {
        'id': '1',
        'datavalue0': phase,
        'datavalue1': group,
        'datavalue2': nameTeacher,
      },
      {
        'id': '2',
        'datavalue0': 'Temporalidad',
        'datavalue1': date,
        'datavalue2': sessions
      },
      {'id': '3', 'datavalue0': 'Problematica:', 'datavalue1': problem},
      {
        'id': '4',
        'datavalue0': 'Nombre de Proyecto',
        'datavalue1': nameproyect
      },
      {'id': '5', 'datavalue0': 'Libro de la NEM:', 'datavalue1': book},
      {'id': '6', 'datavalue0': 'Metodología:', 'datavalue1': methodology},
      {'id': '7', 'datavalue0': 'Proposito:', 'datavalue1': purpose},
      {'id': '8', 'datavalue0': 'Producto:', 'datavalue1': product},
      {'id': '9', 'datavalue0': 'Codiseño:', 'datavalue1': design},
      {'id': '10', 'datavalue0': 'Ejes Articuladores:', 'datavalue1': ejes},
    ];
    List<dynamic>? formativeCamp = [];
    try {
      for (int i = 0; i < pdfsValues.length; i++) {
        int leightdata = formativeCamp.length + 1;
        int j = i + 1;
        String formative = pdfsValues[i]['formative$j'];
        String content = pdfsValues[i]['content$j'];
        String pdas = tabularValores(pdfsValues[i], 'pda');
        formativeCamp.add({
          'id': leightdata,
          'datavalue0': 'Campo Formativo',
          'datavalue1': formative,
        });
        formativeCamp.add({
          'id': leightdata + 1,
          'datavalue0': 'Contenido',
          'datavalue1': content,
        });
        formativeCamp.add({
          'id': leightdata + 1,
          'datavalue0': 'Procesos de Desarrollo y Aprendisaje',
          'datavalue1': pdas,
        });
      }
    } catch (e) {
      print('Se produjo una excepción en formativeCamp: $e');
    }
    print(formativeCamp);
    List<dynamic>? sessionsData = [];
    try {
      for (int i = 0; i < sessionsValues.length; i++) {
        int leightdata = sessionsData.length + 1;
        print(leightdata);
        String datei = sessionsValues[i]['date'];
        DateTime parsedDatei = DateTime.parse(datei);
        String beginning = sessionsValues[i]['beginning'];
        String intermediate = sessionsValues[i]['intermediate'];
        String ending = sessionsValues[i]['ending'];
        String homework = sessionsValues[i]['homework'] ?? '';
        String dateSi =
            '${obtenerNombreDiaSemana(parsedDatei)} ${parsedDatei.day} de ${getMonthName(parsedDatei.month)} del ${parsedDatei.year}';

        sessionsData.add({
          'id': leightdata,
          'datavalue0': beginning,
          'datavalue1': intermediate,
          'datavalue2': ending,
          'datavalue3': homework,
          'date': dateSi,
        });
      }
    } catch (e) {
      print('Se produjo una excepción en sessionsData: $e');
    }
    print(sessionsData);
    PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.letter;
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.top = 5;
    document.pageSettings.margins.left = 32;
    document.pageSettings.margins.right = 32;
    document.pageSettings.margins.bottom = 20;
    PdfFont fontHeader =
        PdfStandardFont(PdfFontFamily.timesRoman, 10, style: PdfFontStyle.bold);

    PdfFont fontBold =
        PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold);
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12,
        style: PdfFontStyle.regular);
    PdfTextAlignment alignmentC = PdfTextAlignment.center;
    PdfTextAlignment alignmentL = PdfTextAlignment.left;
    PdfTextAlignment alignmentJ = PdfTextAlignment.justify;
    double heightT = 0;
    PdfSection section;
    PdfPage page;
    //Section - 1
    section = document.sections!.add();
    page = section.pages.add();
    final Size pageSize = page.getClientSize();
    //Create page settings to the section

    page.graphics.drawImage(PdfBitmap(await readImageData('logo_negro.png')),
        const Rect.fromLTWH(20, 5, 75, 40));
    double distancia = (pageSize.width - (20 + formsValues.length * 40));
    for (int i = 0; i < formsValues.length; i++) {
      try {
        print(formsValues[i]);
        if (formsValues[i]['idformative${i + 1}'] != null) {
          print('entro');
          Map<String, dynamic>? filteredData;

          filteredData = formatives!.firstWhere(
              (image) => image['id'] == formsValues[i]['idformative${i + 1}']);
          print(filteredData);
          page.graphics.drawImage(
              PdfBitmap(await readImageData(filteredData!['image'])),
              Rect.fromLTWH(distancia, 5, 40, 40));
          distancia = distancia + 40;
        }
      } catch (e) {
        print('no existe el id');
      }
    }
    print(heightT);
    heightT = drawHeader(page, pageSize, fontHeader) + 10;
    print(heightT);
    heightT =
        getGrid(page, heightT, data1, 3, fontBold, font, alignmentJ, false);
    print(heightT);
    heightT =
        getGrid(page, heightT, data1, 2, fontBold, font, alignmentL, false);
    print(heightT);
    heightT = getGrid(
        page, heightT, formativeCamp, 2, fontBold, font, alignmentJ, true);

    //metodo para agregar contenido dependiendo el numero de items
    //drawGrid(page, grid, header);
    //Section - 2
    section = document.sections!.add();
    page = section.pages.add();
    heightT = 20;
    heightT = getSessions(page, heightT, sessionsData, 4, fontBold, font,
        alignmentJ, alignmentC, true);

    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Output.pdf');
  }
}

//dibuja el encabezado
double drawHeader(PdfPage page, Size pageSize, PdfFont font) {
  final PdfFont contentFont = font;
  //Draw string
  const String title =
      'COLEGIO PEDAGOGIA FREIREANA\r\nCICLO ESCOLAR 2023-2024\r\nPROYECTO ';
  final Size contentSize = contentFont.measureString(title);

  final PdfLayoutResult header = PdfTextElement(
          text: title,
          font: contentFont,
          format: PdfStringFormat(alignment: PdfTextAlignment.center))
      .draw(
    page: page,
    bounds: Rect.fromLTWH((pageSize.width / 2) - (contentSize.width / 2), 10,
        contentSize.width, 0),
  )!;
  return header.bounds.bottom;
}

double getGrid(
    PdfPage page,
    double button,
    List<dynamic> list,
    int columns,
    PdfFont fontTitle,
    PdfFont fontContent,
    PdfTextAlignment alignment,
    bool istitle) {
  List<dynamic> filteredData =
      list.where((element) => element.keys.length == columns + 1).toList();

  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  double count = 0;
  grid.columns.add(count: columns);
  for (int i = 0; i < filteredData.length; i++) {
    if (istitle) {
      if (i % 3 != 0) {
        addcolums(
            grid, fontTitle, fontContent, filteredData, columns, i, false);
      } else {
        addColumsTitle(grid, fontTitle, fontContent, filteredData, columns, i);
      }
    } else {
      addcolums(grid, fontTitle, fontContent, filteredData, columns, i, false);
    }
  }
  grid.columns[0].width = 200;
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.left;
      } else {
        cell.stringFormat.alignment = alignment;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 2, left: 4, right: 4, top: 4);
    }
  }
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      count = args.bounds.bottom;
    }
  };
  grid.draw(page: page, bounds: Rect.fromLTWH(0, button, 0, 0))!;
  return count;
}

double getSessions(
    PdfPage page,
    double button,
    List<dynamic> list,
    int columns,
    PdfFont fontTitle,
    PdfFont fontContent,
    PdfTextAlignment alignment,
    PdfTextAlignment alignmentHeader,
    bool istitle) {
  //Create a PDF grid
  print('getsessions');
  print(list);
  List<PdfGrid> grids = [];
  double count = 0;
  List<dynamic> headerData = [
    {
      'datavalue0': 'Inicio',
      'datavalue1': 'Desarrollo',
      'datavalue2': 'Cierre',
      'datavalue3': 'Tarea'
    }
  ];

  for (int i = 0; i < list.length; i++) {
    print('fortitles');
    int nSession = i + 1;
    String nDate = '';
    try {
      nSession = list[i]['id'];
      nDate = list[i]['date'];
    } catch (e) {
      print('isnull');
    }
    List<dynamic> sessions = [
      {'datavalue0': 'Sesión $nSession', 'datavalue1': nDate}
    ];
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);
    addColumsTitle(grid, fontTitle, fontContent, sessions, 2, 0);
    grids.add(grid);
    final PdfGrid gridsecond = PdfGrid();
    gridsecond.columns.add(count: columns);
    addColumsTitle(gridsecond, fontTitle, fontContent, headerData, 4, 0);
    grids.add(gridsecond);
    final PdfGrid gridcontent = PdfGrid();
    gridcontent.columns.add(count: columns);
    addcolums(gridcontent, fontTitle, fontContent, list, 4, i, true);
    grids.add(gridcontent);
  }
  int l = 1;
  for (int i = 0; i < list.length * 3; i++) {
    print('forprint');
    l++;
    for (int j = 0; j < grids[i].rows.count; j++) {
      final PdfGridRow row = grids[i].rows[j];
      for (int k = 0; k < row.cells.count; k++) {
        final PdfGridCell cell = row.cells[k];
        if (k == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.left;
        } else {
          cell.stringFormat.alignment = alignment;
        }
        if (l == 3) {
          cell.stringFormat.alignment = alignmentHeader;
          if (k == 3) {
            l = 0;
          }
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 2, left: 4, right: 4, top: 4);
      }
    }
    grids[i].beginCellLayout =
        (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        button = args.bounds.bottom;
      }
    };
    grids[i].draw(page: page, bounds: Rect.fromLTWH(0, button, 0, 0))!;
  }
  count = button;
  return count;
}

Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

String getMonthName(int month) {
  List<String> monthNames = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];
  return monthNames[month - 1];
}

String obtenerNombreDiaSemana(DateTime fecha) {
  List<String> diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  return diasSemana[fecha.weekday - 1];
}
