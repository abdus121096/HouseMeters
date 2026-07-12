import 'package:flutter/material.dart';
import 'indications_screen.dart';
import 'package:flutter/foundation.dart';

class IndicationsNotifier extends ValueNotifier<List<Indications>>{
  IndicationsNotifier(super.value);

  void add(Indications item) {
    value = [...value, item];
  }

  void update(int index, Indications item) {
    final newList = [...value];
    newList[index] = item;
    value = newList;
  }

  void delete(int index) {
    final newList = [...value];
    newList.removeAt(index);
    value = newList;
  }
}