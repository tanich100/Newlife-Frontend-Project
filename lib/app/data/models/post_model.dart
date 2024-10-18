 import 'dart:io';

class PostModel {
  final String postType;
  final String description;
  final String phoneNumber;
  final String lineId;
  final List<File> images;

  PostModel({
    required this.postType,
    required this.description,
    required this.phoneNumber,
    required this.lineId,
    required this.images,
  });
}
  