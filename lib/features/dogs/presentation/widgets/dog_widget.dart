import 'package:flutter/material.dart';
import 'package:konfiotest/features/dogs/data/models/dog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DogWidget extends StatefulWidget {
  const DogWidget({
    super.key,
    this.dog,
  });

  // ignore: diagnostic_describe_all_properties
  final DogModel? dog;

  @override
  State<DogWidget> createState() => _DogWidgetState();
}

class _DogWidgetState extends State<DogWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // Initialize AnimationController with a vsync
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync:
          this, // 'this' refers to the State object which is a TickerProvider
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: SizeTransition(
            sizeFactor: _animation,
            child: buildContent(screenWidth, orientation, context),
          ),
        );
      },
    );
  }

  Column buildContent(
      double screenWidth, Orientation orientation, BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: (screenWidth * 0.5) + 30),
          child: Stack(
            children: [
              buildData(orientation, context),
              buildImage(screenWidth),
            ],
          ),
        ),
      ],
    );
  }

  Positioned buildImage(double screenWidth) {
    return Positioned(
      left: 0,
      bottom: 10.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Radio de las esquinas redondeadas

          child: CachedNetworkImage(
            width: screenWidth * 0.3,
            height: screenWidth * 0.5,
            fit: BoxFit.cover,
            imageUrl: widget.dog!.image ?? '',
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Positioned buildData(Orientation orientation, BuildContext context) {
    return Positioned(
      left: orientation == Orientation.portrait ? 105.0 : 225,
      top: orientation == Orientation.portrait ? 30 : 70,
      right: 0,
      child: Card(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.dog!.dogName!,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: orientation == Orientation.portrait ? 90 : 200,
                    minHeight: orientation == Orientation.portrait ? 74 : 120),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.dog!.description!,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                "Almost ${widget.dog!.age!} years",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
