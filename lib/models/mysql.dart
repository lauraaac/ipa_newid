import 'package:mysql1/mysql1.dart';


class MySql {

  static String host ='newid-assitances.c1o6aai2gn87.us-east-2.rds.amazonaws.com',
                user = 'admin',
                password = 'Filadelfia15*',
                db = 'newid-assitances';

  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {

    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);

  }

}