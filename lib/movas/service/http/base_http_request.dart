import 'dart:io';

abstract class BaseHttpRequest {
  final String endpoint;
  Map<String, dynamic> toMap();
  final ContentType contentType;
  final bool shouldCache;

  BaseHttpRequest({this.endpoint, this.contentType, this.shouldCache = false});
}
