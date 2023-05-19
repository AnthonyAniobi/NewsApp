import 'package:flutter/material.dart';
import 'package:hackernews/models/ask.dart';
import 'package:hackernews/models/comments.dart';
import 'package:hackernews/models/job.dart';
import 'package:hackernews/models/poll.dart';
import 'package:hackernews/models/story.dart';
import 'package:hackernews/services/app_enums.dart';

extension StoryTypeExtension on StoryType {
  String get url {
    switch (this) {
      case StoryType.top:
        return "topstories";
      case StoryType.newstory:
        return "newstories";
      case StoryType.best:
        return "beststories";
      case StoryType.ask:
        return "askstories";
      case StoryType.show:
        return "showstories";
      case StoryType.job:
        return "jobstories";
    }
  }

  String get name {
    switch (this) {
      case StoryType.top:
        return "Top";
      case StoryType.newstory:
        return "New";
      case StoryType.best:
        return "Best";
      case StoryType.ask:
        return "Ask";
      case StoryType.show:
        return "Show";
      case StoryType.job:
        return "Job";
    }
  }
}

extension MapExtension on Map {
  Widget toWidget() {
    switch (this['type']) {
      case Story.type:
        return Story.fromMap(this).toWidget();
      case Comments.type:
        return Comments.fromMap(this).toWidget();
      case Ask.type:
        return Ask.fromMap(this).toWidget();
      case Job.type:
        return Job.fromMap(this).toWidget();
      case Poll.type:
        return Poll.fromMap(this).toWidget();
      default:
        return Container();
    }
  }
}
