import 'dart:io';

/// Reads a fixture file from the test/fixtures directory and returns its contents as a [String].
String fixture(String name) =>
  File('test/fixtures/$name').readAsStringSync();