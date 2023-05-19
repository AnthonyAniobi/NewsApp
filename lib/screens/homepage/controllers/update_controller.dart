import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:hackernews/services/http_request.dart';

class UpdateController extends GetxController {
  RxList<Either<int, Map>> items = <Either<int, Map>>[].obs;
  RxList<String> profiles = <String>[].obs;
  RxBool isLoading = false.obs;

  /// load data from server. If data is alredy loaded return the data
  Future<void> getData() async {
    if (items.isEmpty) {
      refreshData();
    }
  }

  Future<void> loadDetails() async {
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
  Future<void> refreshData() async {
    isLoading.value = true;
    Either<Error, dynamic> result = await HttpRequests.get("updates.json");
    if (result.isRight) {
      Map data = Map.from(result.right);
      items.value = List.generate(
          data['items'].length, (index) => Left(data['items'][index]));
      // items.value =
      //     data['items'].map<Either<int, Map>>((e) => Either<int, Map>).toList();
      profiles.value = List<String>.from(data['profiles']);
    }
    isLoading.value = false;
    loadDetails();
  }
}
