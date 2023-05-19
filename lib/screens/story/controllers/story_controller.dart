import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/services/app_enums.dart';
import 'package:hackernews/services/app_extensions.dart';
import 'package:hackernews/services/http_request.dart';

class StoryController extends GetxController {
  RxList<Either<int, Map>> top = <Either<int, Map>>[].obs;
  RxList<Either<int, Map>> newstory = <Either<int, Map>>[].obs;
  RxList<Either<int, Map>> best = <Either<int, Map>>[].obs;
  RxList<Either<int, Map>> ask = <Either<int, Map>>[].obs;
  RxList<Either<int, Map>> job = <Either<int, Map>>[].obs;
  RxList<Either<int, Map>> show = <Either<int, Map>>[].obs;
  RxBool isLoading = false.obs;

  /// load data from server. If data is alredy loaded return the data
  Future<void> getData(StoryType type) async {
    if (ask.isEmpty || job.isEmpty || show.isEmpty) {
      refreshData(type);
    }
  }

  RxList<Either<int, Map>> listItems(StoryType type) {
    switch (type) {
      case StoryType.top:
        return top;
      case StoryType.newstory:
        return newstory;
      case StoryType.best:
        return best;
      case StoryType.ask:
        return ask;
      case StoryType.show:
        return show;
      case StoryType.job:
        return job;
    }
  }

  Future<void> loadDetails(StoryType type) async {
    RxList<Either<int, Map>> items;
    switch (type) {
      case StoryType.top:
        items = top;
        break;
      case StoryType.newstory:
        items = newstory;
        break;
      case StoryType.best:
        items = best;
        break;
      case StoryType.ask:
        items = ask;
        break;
      case StoryType.show:
        items = show;
        break;
      case StoryType.job:
        items = job;
        break;
    }
    for (int index = 0; index < items.length; index++) {
      if (items[index].isLeft) {
        Either<Error, dynamic> result =
            await HttpRequests.get('item/${items[index].left}.json');
        if (result.isRight) {
          if (result.right == null) {
            continue;
          }
          Map json = Map.from(result.right);
          items[index] = Right(json);
        }
      }
    }
  }

  /// refresh data from server
  Future<void> refreshData(StoryType type) async {
    isLoading.value = true;
    Either<Error, dynamic> topResult =
        await HttpRequests.get("${StoryType.top.url}.json");
    if (topResult.isRight) {
      List<int> data = List<int>.from(topResult.right);
      top.value = List.generate(data.length, (index) => Left(data[index]));
    }
    Either<Error, dynamic> newstoryResult =
        await HttpRequests.get("${StoryType.newstory.url}.json");
    if (newstoryResult.isRight) {
      List<int> data = List<int>.from(newstoryResult.right);
      newstory.value = List.generate(data.length, (index) => Left(data[index]));
    }
    Either<Error, dynamic> bestResult =
        await HttpRequests.get("${StoryType.best.url}.json");
    if (bestResult.isRight) {
      List<int> data = List<int>.from(bestResult.right);
      best.value = List.generate(data.length, (index) => Left(data[index]));
    }
    Either<Error, dynamic> askResult =
        await HttpRequests.get("${StoryType.ask.url}.json");
    if (askResult.isRight) {
      List<int> data = List<int>.from(askResult.right);
      ask.value = List.generate(data.length, (index) => Left(data[index]));
    }
    Either<Error, dynamic> showResult =
        await HttpRequests.get("${StoryType.show.url}.json");
    if (showResult.isRight) {
      List<int> data = List<int>.from(showResult.right);
      show.value = List.generate(data.length, (index) => Left(data[index]));
    }
    Either<Error, dynamic> jobResult =
        await HttpRequests.get("${StoryType.job.url}.json");
    if (jobResult.isRight) {
      List<int> data = List<int>.from(jobResult.right);
      job.value = List.generate(data.length, (index) => Left(data[index]));
    }
    isLoading.value = false;
    loadDetails(type);
  }
}
