import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart';

Future<Connection?> connectToPostgreSQL() async {
  Connection conn;
  try {
    await dotenv.load();
    final host = dotenv.env['host'];
    final database = dotenv.env['database'];
    final username = dotenv.env['username'];
    final password = dotenv.env['password'];
    conn = await Connection.open(
      Endpoint(
        host: host!,
        database: database!,
        username: username!,
        password: password!,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Connected to PostgreSQL database!');

    return conn;
  } catch (e) {
    print('Error connecting to PostgreSQL database: $e');
    return null;
  }
}

Future<void> firstConeccion() async {
  Connection? conn = await connectToPostgreSQL();
  if (conn == null) {
    print('Error connecting to PostgreSQL database');
    return;
  }
  try {
    var result = await conn.execute('SELECT public.listas()');
    var resultList = result.first;

    print(resultList);

    await conn.close();
    print('Connection closed.');
  } catch (e) {
    print('Error executing query: $e');
  }
}
