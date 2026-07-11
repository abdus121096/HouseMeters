import 'package:flutter/material.dart';

class IndicationsScreen extends StatefulWidget {
  const IndicationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IndicationsScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.runtimeType.toString()),);
  }
}