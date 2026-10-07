import 'package:uuid/uuid.dart';

final class UuidHelper {
  UuidHelper._();

  static const Uuid _uuid = Uuid();

  static String generate() {
    return _uuid.v4();
  }
}
