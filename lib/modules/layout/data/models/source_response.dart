
import 'news_response.dart';

class SourceResponse {
  String? status;
  List<Source>? sources;

  SourceResponse({
    this.status,
    this.sources,
  });

  SourceResponse.fromJson(dynamic json) {
    status = json['status'];

    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources!.add(Source.fromJson(v));
      });
    }
  }
}
