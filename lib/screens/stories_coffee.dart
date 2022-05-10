import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation.dart';

class CoffeeStories extends StatelessWidget {
  const CoffeeStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: SafeArea(
          child: CoffeeStoriesContent(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(0),
    );
  }
}

class CoffeeStoriesContent extends StatelessWidget {
  const CoffeeStoriesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
