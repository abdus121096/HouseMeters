import 'package:flutter/material.dart';

class Indications{
  String date;
  int number;

  Indications(this.date, this.number);
}

class IndicationsScreen extends StatefulWidget {
  const IndicationsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<IndicationsScreen> {

  final List<Indications> indications = [
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
  ];


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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 0.5,
          indent: 17,
          endIndent: 17,

        ),
        itemCount: indications.length,
        itemBuilder: (context, index) {
          final item = indications[index];
          return ListTile(
            title: Text(item.date),
            subtitle: Text(item.number.toString()),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
