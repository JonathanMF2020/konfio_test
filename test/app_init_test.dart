import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfiotest/core/bloc_observer/simple_bloc_observer.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_bloc.dart';
import 'package:konfiotest/features/dogs/presentation/pages/dogs_home.dart';
import 'package:konfiotest/injection_container.dart';
import 'package:konfiotest/main.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockDogBloc extends Mock implements DogBloc {}

void main() {
  testWidgets(
      '[Unitaria] Verificación de constuccion de Widget Inicial con sus blocs',
      (WidgetTester tester) async {
    await initializeDependencies();
    Bloc.observer = SimpleBlocObserver();

    await tester.pumpWidget(
      const MyApp(),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(DogsHome), findsOneWidget);
  });
}
