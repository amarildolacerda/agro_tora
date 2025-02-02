import 'package:uuid/uuid.dart';

class GUID {
  // Create an instance of the Uuid class
  static final Uuid _uuid = Uuid();

  // Method to generate a new GUID
  static String create() {
    return _uuid.v4(); // v4 generates a random UUID
  }
}