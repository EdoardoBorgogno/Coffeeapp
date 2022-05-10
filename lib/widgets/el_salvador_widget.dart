import 'package:flutter/material.dart';

class ElSalvadorWidget extends StatelessWidget {
  const ElSalvadorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('El Salvador');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/el_salvador.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withOpacity(0.7),
              BlendMode.color,
            ),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'El Salvador',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mistral',
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Scopri la storia!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Freehand',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
