import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/supabase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseBootstrap.initialize();

  runApp(const BrainBattleApp());
}