import 'package:flutter/material.dart';

class Meter {
  String name;

  Meter(this.name);
}

class MetersScreen extends StatefulWidget {
  const MetersScreen({super.key});

  @override
  State<MetersScreen> createState() => _MetersScreenState();
}

class _MetersScreenState extends State<MetersScreen> {
  final List<Meter> meter = [
    Meter('Электричество'),
    Meter('Холодная вода'),
    Meter('Горячая вода'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 0.5,
          indent: 17,
          endIndent: 17,
        ),
        itemCount: meter.length,
        itemBuilder: (context, index) {
          final item = meter[index];
          return ListTile(
            title: Text(item.name),
          );
        }),
    );
  }
}