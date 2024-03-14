import 'package:planeaciones/connections/connections.dart';
import 'package:postgres/postgres.dart';

Future<dynamic> fContents(
    Map form, int count, Map form2, Stopwatch stopwatch) async {
  List<dynamic>? dataReturn;
  int idFormative = 0;
  int idPhase = 0;
  print('Tiempo inicio busqueda: ${stopwatch.elapsedMilliseconds} ms');

  Connection? conn = await connectToPostgreSQL();
  print('Tiempo de conexión a bd: ${stopwatch.elapsedMilliseconds} ms');

  if (conn == null) {
    print('Error connecting to PostgreSQL database');
    return;
  }
  try {
    idFormative = int.tryParse(form['idformative$count']) ?? 1;
    idPhase = int.tryParse(form2['idphase']) ?? 1;
    var result = await conn.execute(
        'SELECT public.getcontenidosporcampoformativo($idFormative,$idPhase)');
    var firstresult = result.first;
    dataReturn = firstresult.first as List?;
    await conn.close();
    print('Connection closed.');
    return dataReturn;
  } catch (e) {
    print('Error executing query: $e');
    return null;
  }
  //int select = 0;
  //select = (int.tryParse(form['idformative$count']) ?? 1) - 1;
  //return listcontents[select];
}

Future<dynamic> fpdas(Map form, int count, Map form2) async {
  List<dynamic>? dataReturn;
  int idIformative = 0;
  int idGrade = 0;
  Connection? conn = await connectToPostgreSQL();
  if (conn == null) {
    //print('Error connecting to PostgreSQL database');
    return;
  }
  try {
    idIformative = int.tryParse(form['idcontent$count']) ?? 1;
    idGrade = int.tryParse(form2['idgrade']) ?? 1;
    var result = await conn
        .execute('SELECT public.getPdaPorContenido($idIformative,$idGrade)');
    print('a');
    var firstresult = result.first;
    dataReturn = firstresult.first as List?;
    await conn.close();
    //print('Connection closed.');
    return dataReturn;
  } catch (e) {
    //print('Error executing query: $e');
    return null;
  }
  //int select = 0;
  //select = (int.tryParse(form['idformative$count']) ?? 1) - 1;
  //return listcontents[select];
}
