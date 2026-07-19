import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'meters_screen.dart';

class MetersNotifier extends ValueNotifier<List<Meter>>{
  MetersNotifier(super.value);

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/meters_list.json');
  }

  Future<void> _save() async {
    final file = await _getFile();
    final jsonList = value.map((item) => item.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<void> load() async {
    final file = await _getFile();
    if(await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      value = jsonList.map((json) => Meter.fromJson(json)).toList();
    }
  }

  void add(Meter item) {
    value = [...value, item];
    _save();
  }

  void update(int index, Meter item) {
    final newList = [...value];
    newList[index] = item;
    value = newList;
    _save();

  }

  void delete(int index) {
    final newList = [...value];
    newList.removeAt(index);
    value = newList;
    _save();
  }
}