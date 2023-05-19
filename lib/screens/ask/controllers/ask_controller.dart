import 'dart:math' as math;

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/ask.dart';
import 'package:hackernews/services/http_request.dart';

class AskController extends GetxController {
  RxList<Map> allComments = <Map>[].obs;
  RxInt loadMoreIndex = 0.obs;
  final int _maxPerPage = 5;

  Future<void> loadMore(Ask ask) async {
    int firstIndex = loadMoreIndex.value * _maxPerPage;
    if (firstIndex > ask.kids.length) {
      return;
    }
    loadMoreIndex++;
    int lastIndex =
        math.min(loadMoreIndex.value * _maxPerPage, ask.kids.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${ask.kids[i]}.json');
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
