import 'dart:io';

class PostModel {
  final String description;
  final String phoneNumber;
  final String lineId;
  final String postType;
  final List<File> images;

  PostModel({
    required this.description,
    required this.phoneNumber,
    required this.lineId,
    required this.postType,
    required this.images,
  });
}
