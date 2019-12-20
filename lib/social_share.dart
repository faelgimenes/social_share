import 'dart:async';
import 'package:flutter/services.dart';

class SocialShare {
  static const MethodChannel _channel = const MethodChannel('social_share');

  static Future<String> shareInstagramStory(
      String imagePath,
      String backgroundTopColor,
      String backgroundBottomColor,
      String attributionURL) async {
    final Map<String, dynamic> args = <String, dynamic>{
      "stickerImage": imagePath,
      "backgroundTopColor": backgroundTopColor,
      "backgroundBottomColor": backgroundBottomColor,
      "attributionURL": attributionURL
    };

    final String response =
        await _channel.invokeMethod('shareInstagramStory', args);

    return response;
  }

  static Future<String> shareInstagramStorywithBackground(
      String imagePath,
      String backgroundTopColor,
      String backgroundBottomColor,
      String attributionURL,
      {String backgroundImagePath}) async {
    final Map<String, dynamic> args = <String, dynamic>{
      "stickerImage": imagePath,
      "backgroundImage": backgroundImagePath,
      "backgroundTopColor": backgroundTopColor,
      "backgroundBottomColor": backgroundBottomColor,
      "attributionURL": attributionURL
    };

    final String response =
        await _channel.invokeMethod('shareInstagramStory', args);

    return response;
  }

  static Future<String> shareFacebookStory(
      String imagePath,
      String backgroundTopColor,
      String backgroundBottomColor,
      String attributionURL) async {
    final Map<String, dynamic> args = <String, dynamic>{
      "stickerImage": imagePath,
      "backgroundTopColor": backgroundTopColor,
      "backgroundBottomColor": backgroundBottomColor,
      "attributionURL": attributionURL,
    };

    final String response =
        await _channel.invokeMethod('shareFacebookStory', args);
    return response;
  }

  static Future<String> shareTwitter(String captionText,
      {List<String> hashtags}) async {
    Map<String, dynamic> args;
    if (hashtags != null && hashtags.isNotEmpty) {
      String tags = "";
      hashtags.forEach((f) {
        tags += ("%23" + f.toString() + " ").toString();
      });
      print(tags);
      print(Uri.parse(captionText + tags.toString()).toString());
      args = <String, dynamic>{
        "captionText":
            Uri.parse(captionText + "\n" + tags.toString()).toString(),
      };
    } else {
      args = <String, dynamic>{
        "captionText": Uri.parse(captionText).toString(),
      };
    }
    final String version = await _channel.invokeMethod('shareTwitter', args);
    return version;
  }

  static Future<String> shareSms(String message, {String url}) async {
    Map<String, dynamic> args;
    if (url == null) {
      print("url is null");
      args = <String, dynamic>{
        "message": Uri.parse(message).toString(),
      };
    } else {
      print(Uri.parse(url).toString());
      var msg = Uri.parse(message).toString() +
          "%20" +
          Uri.parse(url.toString()).toString();
      print(msg);
      args = <String, dynamic>{
        "message": Uri.parse(message + " ").toString(),
        "urlLink": Uri.parse(url).toString(),
      };
    }
    final String version = await _channel.invokeMethod('shareSms', args);
    return version;
  }

  static Future<bool> copyToClipboard(content) async {
    final Map<String, String> args = <String, String>{
      "content": content.toString()
    };
    final bool response = await _channel.invokeMethod('copyToClipboard', args);
    return response;
  }

  static Future<bool> shareOptions(String imagePath, String contentText) async {
    final Map<String, dynamic> args = <String, dynamic>{
      "image": imagePath,
      "content": contentText
    };
    final bool version = await _channel.invokeMethod('shareOptions', args);
    return version;
  }
  // static Future<String> shareWhatsapp() async {
  //   final String version = await _channel.invokeMethod('shareWhatsapp');
  //   return version;
  // }

  // static Future<String> shareTelegram() async {
  //   final String version = await _channel.invokeMethod('shareTelegram');
  //   return version;
  // }

  // static Future<String> shareSlack() async {
  //   final String version = await _channel.invokeMethod('shareSlack');
  //   return version;
  // }
}
