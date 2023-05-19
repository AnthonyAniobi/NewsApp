import 'dart:math' as math;

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/comments.dart';
import 'package:hackernews/services/http_request.dart';

class CommentController extends GetxController {
  RxList<Map> allComments = <Map>[].obs;
  RxInt loadMoreIndex = 0.obs;
  final int _maxPerPage = 5;

  Future<void> loadMore(Comments comments) async {
    int firstIndex = loadMoreIndex.value * _maxPerPage;
    if (firstIndex > comments.kids.length) {
      return;
    }
    loadMoreIndex++;
    int lastIndex =
        math.min(loadMoreIndex.value * _maxPerPage, comments.kids.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${comments.kids[i]}.json');
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
