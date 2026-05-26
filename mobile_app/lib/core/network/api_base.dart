import 'dart:io';
import 'package:flutter/foundation.dart';

const String _lanPc = 'http://192.168.1.169'; // PC IP without port
const String _localhost = 'http://localhost'; 
const String _emu = 'http://10.0.2.2';       

String _baseHost() {
  const fromEnv = String.fromEnvironment('API_HOST', defaultValue: '');
  if (fromEnv.isNotEmpty) return fromEnv;

  if (kIsWeb) return _localhost;

  if (Platform.isAndroid) {
    const isEmulator = bool.fromEnvironment('IS_EMULATOR', defaultValue: false);
    return isEmulator ? _emu : _lanPc;
  }
  return _localhost;
}

String apiBase() {
  return '${_baseHost()}:3000';
}
