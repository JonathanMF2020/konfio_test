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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animation,
          child: SizeTransition(
            sizeFactor: _animation,
            child: buildContent(context),
          ),
        );
      },
    );
  }

  Container buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 19),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Row(
              children: [
                buildImage(),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Expanded(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 160, minHeight: 160),
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10), // Esquina superior derecha redondeada
                            bottomRight: Radius.circular(
                                10), // Esquina inferior derecha redondeada
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                        ),
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      widget.dog!.dogName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Text(
                                    widget.dog!.description!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: Text(
                                      "Almost ${widget.dog!.age!} years",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildImage() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.dog!.image ?? '',
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Expanded buildData(
      Orientation orientation, BuildContext context, double screenWidt) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
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
                        maxHeight:
                            orientation == Orientation.portrait ? 90 : 200,
                        minHeight:
                            orientation == Orientation.portrait ? 74 : 120),
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
            ],
          ),
        ),
      ),
    );
  }
}
