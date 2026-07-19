import 'package:flutter/material.dart';
import 'package:house_meters/indications_screen.dart';

class Meter {
  String name;
  int intValue;

  Meter(this.name, this.intValue);
}

class MetersScreen extends StatefulWidget {
  const MetersScreen({super.key});

  @override
  State<MetersScreen> createState() => _MetersScreenState();
}

class _MetersScreenState extends State<MetersScreen> {
  final List<Meter> meter = [
    Meter('Электричество', 0),
    Meter('Холодная вода', 0),
    Meter('Горячая вода', 0),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('отмена'),
            ),
            TextButton(
              onPressed: () {
                final name = controller1.text;
                final value = int.tryParse(controller2.text);
                if (name.isNotEmpty && value != null) {
                  setState(() {
                    meter.add(Meter(name, value));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _editDialog(BuildContext context, int index) {
    final item = meter[index];
    final TextEditingController controller3 = TextEditingController(text: item.name);
    final TextEditingController controller4 = TextEditingController(text: item.intValue.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Изменения счетчика'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: controller3),
              TextField(controller: controller4, enabled: false),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  meter.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('удалить'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('отмена'),
            ),
            TextButton(
              onPressed: () {
                final name2 = controller3.text;
                if (name2.isNotEmpty) {
                  setState(() {
                    meter[index] = Meter(name2, item.intValue);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('сохранить'),
            ),
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
          return ListTile(
            title: Text(item.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IndicationsScreen()),
              );
            },
            onLongPress: () {
              _editDialog(context, index);
            },
          );
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
