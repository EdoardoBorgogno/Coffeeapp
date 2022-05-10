import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/el_salvador_widget.dart';
import 'package:coffeapp/widgets/coffe_now.dart';
import 'package:coffeapp/widgets/coffeland_widget.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 1,
          child: CarouselSlider(
            items: [
              const ElSalvadorWidget(),
              const CoffeeLandWidget(),
              const CoffeeNowWidget()
            ].toList(),
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              initialPage: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 6),
              aspectRatio: 0.1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
