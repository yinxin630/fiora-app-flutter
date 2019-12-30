import '../utils/fetch.dart' as Fetch;

class Service {
  static loginWithPass(String username, String password) async {
    var result = await Fetch.fetch('login', {
      'username': username,
      'password': password,
    });
    // TODO: convert dynamic to class
    return result;
  }
}
