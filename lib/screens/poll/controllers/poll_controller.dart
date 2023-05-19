import 'dart:math' as math;

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/poll.dart';
import 'package:hackernews/services/http_request.dart';

class PollController extends GetxController {
  RxList<Map> allComments = <Map>[].obs;
  RxList<Map> allParts = <Map>[].obs;
  RxInt loadMorePollIndex = 0.obs;
  RxInt loadMoreCommentIndex = 0.obs;
  final int _maxPerPage = 5;

  Future<void> loadPollMore(Poll poll) async {
    int firstIndex = loadMorePollIndex.value * _maxPerPage;
    if (firstIndex > poll.parts.length) {
      return;
    }
    loadMorePollIndex++;
    int lastIndex =
        math.min(loadMorePollIndex.value * _maxPerPage, poll.kids.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${poll.parts[i]}.json');
      if (result.isRight) {
        if (result.right == null) {
          continue;
        }
        Map json = Map.from(result.right);
        allParts.add(json);
      }
    }
  }

  Future<void> loadMoreComment(Poll poll) async {
    int firstIndex = loadMoreCommentIndex.value * _maxPerPage;
    if (firstIndex > poll.kids.length) {
      return;
    }
    loadMoreCommentIndex++;
    int lastIndex =
        math.min(loadMoreCommentIndex.value * _maxPerPage, poll.kids.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${poll.kids[i]}.json');
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
