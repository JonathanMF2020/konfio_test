import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_event.dart';
import 'package:konfiotest/injection_container.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/theme.dart';
import 'core/bloc_observer/simple_bloc_observer.dart';
import 'features/dogs/presentation/bloc/dog/dog_bloc.dart';
import 'features/dogs/presentation/pages/dogs_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DogBloc>(
          create: (context) => sl<DogBloc>()..add(const GetDogs()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: 'Konfio Test',
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DogsHome(),
      ),
    );
  }
}
