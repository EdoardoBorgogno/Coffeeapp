import 'package:flutter/material.dart';

import '../widgets/custom_bottom_navigation.dart';

class CoffeAccount extends StatelessWidget {
  const CoffeAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: SafeArea(
          child: CoffeAccountContent(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(2),
    );
  }
}

class CoffeAccountContent extends StatelessWidget {
  const CoffeAccountContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
