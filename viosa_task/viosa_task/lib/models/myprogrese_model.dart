import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

class ProgressModel {
  Result? result;
  Title? title;
  Value? value;

  ProgressModel({this.result, required String title, required String value,});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? totalChapters;
  int? totalWatchedTime;
  int? completedChapters;

  Result({this.totalChapters, this.totalWatchedTime, this.completedChapters});

  Result.fromJson(Map<String, dynamic> json) {
    totalChapters = json['totalChapters'];
    totalWatchedTime = json['totalWatchedTime'];
    completedChapters = json['completedChapters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalChapters'] = this.totalChapters;
    data['totalWatchedTime'] = this.totalWatchedTime;
    data['completedChapters'] = this.completedChapters;
    return data;
  }
}
