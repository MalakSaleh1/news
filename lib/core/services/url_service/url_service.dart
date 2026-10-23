import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static Future<void> openArticle(BuildContext context, String? url) async {
    final uri = url == null ? null : Uri.tryParse(url);
    final opened = uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed open the url')),
      );
    }
  }
}