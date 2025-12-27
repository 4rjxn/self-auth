import 'package:flutter/material.dart';

class HomePageLoadingScreen extends StatelessWidget {
  const HomePageLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Colors.white));
  }
}
