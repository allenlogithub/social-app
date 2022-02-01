import "dart:io";

import 'package:yaml/yaml.dart';

const String path = 'assets/config/dev.yaml';

Future<void> appCfg() async {
  final configFile = File(path);
  final yamlString = await configFile.readAsString();
  final dynamic yamlMap = loadYaml(yamlString);
  print(yamlMap['server']['user']['baseUrl']);
  print(yamlMap['server']['post']['baseUrl']);
}

// const Map server_domain = {
//   'user': 'http://192.168.8.144:90',
//   'post': 'http://192.168.8.144:93',
// };
