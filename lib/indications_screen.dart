import 'package:flutter/material.dart';
import 'indications_notifier.dart';

class Indications {
  String date;
  int number;

  Indications(this.date, this.number);

  Map<String, dynamic> toJson() => {'date': date, 'number': number};

  factory Indications.fromJson(Map<String, dynamic> json) {
    return Indications(json['date'], json['number']);
  }
}

class IndicationsScreen extends StatefulWidget {
  const IndicationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IndicationsScreen> {
  final IndicationsNotifier notifier = IndicationsNotifier([
    Indications('01.01.2024', 16209),
    Indications('01.02.2024', 16279),
    Indications('01.03.2024', 16381),
    Indications('01.04.2024', 16483),
    Indications('01.05.2024', 16569),
    Indications('01.06.2024', 16673),
    Indications('01.07.2024', 16825),
    Indications('01.08.2024', 16952),
    Indications('01.09.2024', 17083),
    Indications('01.10.2024', 17165),
    Indications('01.11.2024', 17214),
    Indications('01.12.2024', 17253),
  ]);

  bool loading = true;

  @override
  void initState() {
    super.initState();

    notifier.load().then((_) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

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
                        '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}',
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
                TextButton(
                  onPressed: () {
                    final number = int.tryParse(controller.text);
                    if (number != null) {
                      final date =
                          '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}';
                      notifier.add(Indications(date, number));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editDialog(BuildContext context, int index) {
    final item = notifier.value[index];
    final dateInt = item.date.split('.');
    DateTime selectedDate = DateTime(
      int.parse(dateInt[2]),
      int.parse(dateInt[1]),
      int.parse(dateInt[0]),
    );
    final TextEditingController controller = TextEditingController(
      text: item.number.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Изменения показания'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}',
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
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    notifier.delete(index);
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
                    final number = int.tryParse(controller.text);
                    if (number != null) {
                      final date =
                          '${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}';
                      notifier.update(index, Indications(date, number));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('сохранить'),
                ),
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
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, indications, _) {
                  if (indications.isEmpty) {
                    return Text('Не добавлено ни одного показания');
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 17,
                      endIndent: 17,
                    ),
                    itemCount: indications.length,
                    itemBuilder: (context, index) {
                      final item = indications[index];
                      return GestureDetector(
                        onLongPress: () {
                          _editDialog(context, index);
                        },
                        child: ListTile(
                          title: Text(item.date),
                          subtitle: Text(item.number.toString()),
                        ),
                      );
                    },
                  );
                },
              ),
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
