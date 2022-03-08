import 'package:flutter/material.dart';

class GenericOnBoardingPage extends StatefulWidget {
  GenericOnBoardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.moreInfo,

  }) : super(key: key);

  late String title;
  late String description;
  late String imagePath;
  String? moreInfo;

  @override
  State<GenericOnBoardingPage> createState() => _GenericOnBoardingPageState();
}

class _GenericOnBoardingPageState extends State<GenericOnBoardingPage> {
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 45),
                child: Image.asset(widget.imagePath)),
            Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 23,
                          wordSpacing: 1,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w900,
                        )
                  ),
                )
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Center(
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.7,
                      height: 1.5,
                      fontWeight: FontWeight.w600
                    ),
              )),
            ),
            if (widget.moreInfo != null) Container(
              width: double.infinity,
              child: Center(
                  child: Text(
                    widget.moreInfo!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      letterSpacing: 0.7,
                      height: 1.5,
                    ),
              )),
            ) else const SizedBox()
          ],
        ),
      );
  }
}
