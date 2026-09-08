import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../network/dio_client.dart';

/// Registers types this app doesn't own the constructor of — get_it/injectable
/// can only annotate classes we author, so anything third-party (or built via
/// a factory function, like [buildDioClient]) goes through a `@module` getter
/// instead. Both getters are lazy, so [Supabase.instance] is only actually
/// touched the first time something needs a [SupabaseClient] — always after
/// `Supabase.initialize()` has completed in `main()`.
@module
abstract class RegisterModule {
  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  Dio get dio => buildDioClient();
}
