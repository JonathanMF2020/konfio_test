import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konfiotest/core/constants/colors.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_bloc.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_state.dart';
import 'package:konfiotest/features/dogs/presentation/widgets/dog_widget.dart';

class DogsHome extends StatelessWidget {
  const DogsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => print("Back"),
      ),
      title: const Text(
        'Dogs We Love',
      ),
    );
  }

  Container _buildBody() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: BlocBuilder<DogBloc, DogState>(
        builder: (_, state) {
          if (state is DogLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is DogError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (state is DogDone) {
            if (state.dogs.isEmpty) {
              return const Center(
                child: Text('No dogs available'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return DogWidget(
                  dog: state.dogs[index],
                );
              },
              itemCount: state.dogs.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
