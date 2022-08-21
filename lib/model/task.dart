// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String title;
  String description;
  String id;
  String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task(
      {required this.title,
      required this.description,
      required this.id,
      required this.date,
      this.isDone,
      this.isFavorite,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    String? id,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'title': title,
      'id': id,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      id: map['id'],
      date: map['date'],
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props =>
      [title, date, description, id, isDone, isDeleted, isFavorite];
}
