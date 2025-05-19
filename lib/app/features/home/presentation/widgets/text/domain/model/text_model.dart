import 'package:equatable/equatable.dart';

class TextModel extends Equatable {
  const TextModel({
    this.title,
  });

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      title: json['title'],
    );
  }

  final String? title;

  @override
  List<Object?> get props => [title];
}
