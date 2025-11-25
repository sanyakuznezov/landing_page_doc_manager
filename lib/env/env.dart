// lib/env/grouter.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'secret_key.env')
abstract class Env {
  @EnviedField(varName: 'FIREBASE_KEY',obfuscate: true)
  static final String keyFirebase = _Env.keyFirebase;

}