import 'package:flutter/material.dart';
import 'package:hnest/helpers/palette_helper.dart';

import '../helpers/auto_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PaletteHelper.getColor(AppColorId.primaryColor.value),
          title: Text(widget.title, textAlign: TextAlign.center, style: AutoTheme.getH1Style(StyleDimension.bold)),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Container(
          color: PaletteHelper.getColor(AppColorId.primaryColor.value),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Container(
                    color: Colors.brown,
                  ),
                ),
              ),
              Positioned(
                  bottom: 25,
                  right: 25,
                  child: SizedBox(height: 140, width: 140, child: Image.asset('assets/images/community_logo.png')))
            ],
          ),
        )));
  }
}
