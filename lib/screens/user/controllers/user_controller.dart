import 'dart:math' as math;

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/models/user.dart';
import 'package:hackernews/services/http_request.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<User> user = Rxn();
  RxList<Map> submitted = <Map>[].obs;
  RxInt loadMoreIndex = 0.obs;
  final int _maxPerPage = 5;

  Future<void> loadUser(String id) async {
    isLoading.value = true;
    Either<Error, dynamic> result = await HttpRequests.get('user/$id.json');
    if (result.isRight) {
      Map data = result.right as Map;
      user.value = User.fromMap(data);
      loadMore();
    }
    isLoading.value = false;
  }

  Future<void> loadMore() async {
    int firstIndex = loadMoreIndex.value * _maxPerPage;
    if (firstIndex > user.value!.submitted.length) {
      return;
    }
    loadMoreIndex++;
    int lastIndex = math.min(
        loadMoreIndex.value * _maxPerPage, user.value!.submitted.length);
    for (int i = firstIndex; i < lastIndex; i++) {
      Either<Error, dynamic> result =
          await HttpRequests.get('item/${user.value!.submitted[i]}.json');
      if (result.isRight) {
        if (result.right == null) {
          continue;
        }
        Map json = Map.from(result.right);
        submitted.add(json);
      }
    }
  }
}
