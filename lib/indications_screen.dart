import 'package:flutter/material.dart';

class IndicationsScreen extends StatefulWidget {
  const IndicationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IndicationsScreen> {
  void _addDialog(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Добавление показания'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                      ),
                      IconButton(
                        onPressed: () async {
                          final picker = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2099),
                          );
                          if (picker != null) {
                            setStateDialog(() {
                              selectedDate = picker;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'новые показания'),
                    keyboardType: TextInputType.number,
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
                TextButton(onPressed: () {}, child: Text('добавить')),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.runtimeType.toString())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
