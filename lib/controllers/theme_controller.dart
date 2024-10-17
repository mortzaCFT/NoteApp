import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    GetStorage().write('isDarkMode', isDarkMode.value);
  }

  void loadTheme() {
    isDarkMode.value = GetStorage().read('isDarkMode') ?? false;
  }
}