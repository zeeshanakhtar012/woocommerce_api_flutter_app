import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favoriteItems = <int>{}.obs;

  void toggleFavorite(int productId) {
    if (favoriteItems.contains(productId)) {
      favoriteItems.remove(productId);
    } else {
      favoriteItems.add(productId);
    }
  }

  bool isFavorite(int productId) {
    return favoriteItems.contains(productId);
  }
}
