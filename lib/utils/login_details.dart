import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/respositories/user_repo.dart';
import 'package:talentogram/screens/auth_screens/login.dart';

class UserDetail extends GetxController {
  int userId = 0;
  String name = '';
  String image = '';
  String email = '';
  int earningVisible = 1;
  int isEmailVerified = 0;

  Future<void> setData(Map result) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = result['token'] ?? '';
    String image = result['user']['image'] ?? '';
    String email = result['user']['email'];
    String firstName = result['user']['firstName'];
    String lastName = result['user']['lastName'];
    int id = result['user']['userId'];
    await sharedPreferences.setString(SharedPrefKey.KEY_ACCESS_TOKEN, token);
    await sharedPreferences.setString('name', '$firstName $lastName');
    await sharedPreferences.setInt(
        'earningVisibility', result['user']['earningVisibility'] ?? 1);
    await sharedPreferences.setInt(SharedPrefKey.KEY_USER_ID, id);
    await sharedPreferences.setString(SharedPrefKey.KEY_USER_IMAGE, image);
    await sharedPreferences.setBool(SharedPrefKey.KEY_IS_LOGIN, true);
    await sharedPreferences.setString('email', email);
    Get.find<UserDetail>().getData();
  }

  Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name') ?? '';
    userId = sharedPreferences.getInt(SharedPrefKey.KEY_USER_ID) ?? 0;
    image = sharedPreferences.getString(SharedPrefKey.KEY_USER_IMAGE) ?? '';
    earningVisible = sharedPreferences.getInt('earningVisibility') ?? 1;
    isEmailVerified = sharedPreferences.getInt('isEmailVerified') ?? 0;
    email = sharedPreferences.getString('email') ?? '';
    update();
  }

  Future<bool> isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(SharedPrefKey.KEY_IS_LOGIN) ?? false;
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('islogin');
    Get.offAll(() => const Login());
  }

  bool get isEarningVisible => earningVisible == 1;
  bool get isVerified => isEmailVerified == 1;
  editVisibility() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    earningVisible = earningVisible == 0 ? 1 : 0;
    await sharedPreferences.setInt('earningVisibility', earningVisible);
    update();
    UserRepo().changeEarningVisible(earningVisible);
  }

  verify() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('isEmailVerified', 1);
    getData();
  }

  updateProfile(String img, String firstN, String lastN) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('name', "$firstN $lastN");
    await sharedPreferences.setString('image', img);
    getData();
  }
}
