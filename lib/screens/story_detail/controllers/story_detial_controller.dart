import 'dart:math' as math;

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/story.dart';
import 'package:hackernews/services/http_request.dart';

class StoryDetailController extends GetxController {
  RxList<Map> allComments = <Map>[].obs;
  RxInt loadMoreIndex = 0.obs;
  final int _maxPerPage = 5;

  Future<void> loadMore(Story story) async {
    int firstIndex = loadMoreIndex.value * _maxPerPage;
    if (firstIndex > story.kids.length) {
      return;
    }
    loadMoreIndex++;
    int lastIndex =
        math.min(loadMoreIndex.value * _maxPerPage, story.kids.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${story.kids[i]}.json');
      if (result.isRight) {
        if (result.right == null) {
          continue;
        }
        Map json = Map.from(result.right);
        allComments.add(json);
      }
    }
  }
}
