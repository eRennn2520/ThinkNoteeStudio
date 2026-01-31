
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime createdAt;

  NoteModel({
    required this.title,
    required this.content,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};

    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }

    return NoteModel(
      title: fields[0] as String,
      content: fields[1] as String,
      createdAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.createdAt);
  }
}

class NoteProvider extends ChangeNotifier {
  static const String _boxName = 'notes_box';

  late Box<NoteModel> _noteBox;
  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  /// Hive box açılırken çağrılmalı
  Future<void> init() async {
    _noteBox = await Hive.openBox<NoteModel>(_boxName);
    _notes = _noteBox.values.toList();
    notifyListeners();
  }

  /// Yeni not ekle
  void addNote({
    required String title,
    required String content,
  }) {
    final note = NoteModel(
      title: title,
      content: content,
    );

    _noteBox.add(note);
    _notes.add(note);
    notifyListeners();
  }

  /// Not sil
  void deleteNote(int index) {
    if (index < 0 || index >= _notes.length) return;

    _noteBox.deleteAt(index);
    _notes.removeAt(index);
    notifyListeners();
  }

  /// Tüm notları temizle (opsiyonel)
  void clearAll() {
    _noteBox.clear();
    _notes.clear();
    notifyListeners();
  }
}
