import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_client.dart';

/// Provides a single shared [DioClient] instance across the app.
/// Lives in the core/network layer — no feature-specific knowledge here.
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});
