import 'package:http/http.dart' as http;
import 'package:ray/request.dart';

class Client {
  static Map<String, List> cache = {};
  int portNumber;
  String host;
  String? fingerprint;
  RayClient _http = RayClient();

  Client({this.portNumber = 23517, this.host = 'localhost'}) {
    fingerprint = '$host:$portNumber';
  }

  Future<bool> serverIsAvailable() async {
//    TODO Purge expired cache

    if (!cache.containsKey(fingerprint)) {
      await this.performAvailabilityCheck();
    }

    print("fingerprint :" + (fingerprint ?? '-'));
    print((cache[fingerprint]?[0] ?? true) ? 'yep' : 'nope');

    return cache[fingerprint]?[0] ?? true;
  }

  Future<bool> performAvailabilityCheck() async {
    bool success = false;
    try {
      var response = await _http.get(getUrl('_availability_check'));
      // print(response.body);
      print("Response: " + response.statusCode.toString());
      // Added response.statusCode == 400 to work with Buggregator as well.
      success = response.statusCode == 404 || response.statusCode == 400;
//      Expires after 30 seconds
      if (fingerprint != null) {
        cache[fingerprint ?? ''] = [
          success,
          DateTime.now().millisecondsSinceEpoch + 30
        ];
      }
    } finally {
      print(success ? 'available' : 'unavailable');
      return success;
    }
  }

  Future<void> send(Request request) async {
    bool isAvailable = await serverIsAvailable();
    if (!isAvailable) {
      print('server not available');
      return;
    }

    try {
      await _http.post(getUrl(''), body: request.toJson());
    } catch (e) {
      print(e);
    }
  }

  Uri getUrl(String path) {
    var urlString = 'http://$host:$portNumber/$path';

    return Uri.parse(urlString);
  }
}

class RayClient extends http.BaseClient {
  final http.Client _client = http.Client();

  RayClient();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = 'Ray 1.0';
    request.headers['Accept'] = 'application/json';
    request.headers['Content-Type'] = 'application/json';
    return _client.send(request);
  }
}
