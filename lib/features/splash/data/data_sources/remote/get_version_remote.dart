import 'package:supabase_flutter/supabase_flutter.dart';

class GetRemoteVersion {
  final SupabaseClient supabaseClient;

  GetRemoteVersion({required this.supabaseClient});
  Future<Map<String, dynamic>> getRemoteVersion() async {
    final version = await supabaseClient.from("clinic_app_version").select();
    return version.last;
  }
}
