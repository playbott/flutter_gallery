import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/bloc.dart';
import 'presentation/screens/screens.dart';
import 'presentation/widgets/widgets.dart';

Future<void> appInitialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init();

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
}

Future<void> main() async {
  await appInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final _title = 'Offline Mini Photo Gallery';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        title: _title,
        home: ToastWrapper(child: ProductsScreen(appTitle: _title)),
      ),
    );
  }
}
