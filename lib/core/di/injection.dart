import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kairo_gallery/core/theme/theme_cubit.dart';
import 'package:kairo_gallery/features/auth_lock/data/datasources/secure_pin_datasource.dart';
import 'package:kairo_gallery/features/auth_lock/domain/repositories/auth_lock_repository.dart';
import 'package:kairo_gallery/features/auth_lock/domain/repositories/auth_lock_repository_impl.dart';
import 'package:kairo_gallery/features/auth_lock/domain/usecases/verify_pin.dart';
import 'package:kairo_gallery/features/auth_lock/presentation/cubit/auth_lock_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // TODO: Registrar repositórios, cubits, datasources
  // Exemplo:
  // sl.registerLazySingleton<EmailRepository>(() => EmailRepositoryImpl(sl()));
  // sl.registerFactory(() => InboxCubit(sl()));

  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<SecurePinDatasource>(() => SecurePinDatasource(sl()));
  sl.registerLazySingleton<AuthLockRepository>(() => AuthLockRepositoryImpl(sl()));
  sl.registerLazySingleton(() => VerifyPin(sl()));
  sl.registerLazySingleton(() => SetPin(sl()));
  sl.registerLazySingleton(() => HasPinConfigured(sl()));
  sl.registerLazySingleton(() => AuthLockCubit(hasPinConfigured: sl(), verifyPin: sl(), setPin: sl()));

  sl.registerSingleton<ThemeCubit>(ThemeCubit(sl<FlutterSecureStorage>()));
  await sl<ThemeCubit>().loadTheme();
}
