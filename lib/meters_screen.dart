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

  void _addDialog(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить счетчик'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller1,
                decoration: InputDecoration(hintText: 'название'),
              ),
              TextField(
                controller: controller2,
                decoration: InputDecoration(hintText: 'начальные показания'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('отмена')),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('сохранить')),
          ],
        );
      },
    );
  }

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
          return ListTile(title: Text(item.name));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
