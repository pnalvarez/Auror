import 'package:auror/app_bootstrap.dart';
import 'package:auror/core/http/supabase_http_logging.dart';

Future<void> main() => bootstrapAuror(
      enableSupabaseVerboseLogging: shouldLogSupabaseHttp(),
    );
