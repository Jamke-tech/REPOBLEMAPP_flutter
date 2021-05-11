class Endpoints {
  //Hacemos un singleton para tener los datos simpre igual en todas las intancia de busqueda
  static Endpoints _instance;

  Endpoints._internal();

  static Endpoints getInstance() {
    if (_instance == null) {
      _instance = Endpoints._internal();
    }
    return _instance;
  }

  //Valores de las API points
  //final String IpApi = '127.0.0.1:25000';
  final String IpApi = '10.0.2.2:25000';
  final String photoIP = '10.0.2.2:25000';
}
