import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../features/book_finder/data/datasources/book_remote_data_source.dart';
import '../../../features/book_finder/domain/repositories/book_repository.dart';
import '../../../features/book_finder/domain/usecases/search_books.dart';
import '../../../features/book_finder/presentation/bloc/book_bloc.dart';
import '../../features/book_finder/data/repository_impl/book_repository_impl.dart';
import '../platform_channel_service.dart';
import '../../features/device_sensor/presentation/cubit/dashboard_cubit.dart';
import '../../features/device_sensor/presentation/cubit/sensor_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => BookBloc(sl()));
  sl.registerLazySingleton(() => SearchBooks(sl()));
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => BookRemoteDataSource());

  
  sl.registerLazySingleton(() => PlatformChannelService());
  sl.registerFactory(() => DashboardBloc(sl()));
  sl.registerFactory(() => SensorBloc(sl()));

  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    join(dbPath, 'books.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE books(title TEXT, author TEXT, coverUrl TEXT)');
    },
    version: 1,
  );
  sl.registerLazySingleton<Database>(() => db);
}
