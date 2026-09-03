import "package:get/get.dart";
import "package:app/services/auth_service.dart";

class AuthController extends GetxController {
  AuthService authService = AuthService();
  var isLoading = false.obs;

  Future<bool> register(String userEmail, String userPassword) async {
    isLoading.value = true;
    bool successCheck = await authService.register(userEmail, userPassword);

    isLoading.value = false;
    return successCheck;
  }

  Future<bool> login(String userEmail, String userPassword) async {
    isLoading.value = true;
    bool successCheck = await authService.login(userEmail, userPassword);
    isLoading.value = false;
    return successCheck;
  }

  Future<void> logout() async {
    await authService.logout();
  }
}
