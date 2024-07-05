import 'package:cm/controllers/popular_product_controller.dart';
import 'package:cm/data/api/api_client.dart';
import 'package:cm/data/repository/popular_product_repo.dart';
import 'package:cm/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async {
  //API Client
  //for localhost apple device emulator - use 127.0.0.1:8083
  //for android emulator - use 10.0.2.2:8083
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));

  // Check API connectivity
  //await checkApiConnectivity();

}

// Future<void> checkApiConnectivity() async {
//   final apiClient = Get.find<ApiClient>();
//   print("inside the check api connectivity");
//   try {
//     final Response<dynamic> response = await apiClient.testConnectivity(); // Implement a method in ApiClient to test connectivity
//     if (response != null) {
//       // Access response data here
//       dynamic responseData = response.body;
//       print('Response Data: $responseData');
//       print('status code: ${response.statusCode} - ${response.statusText}');
//     }else{
//       print("No response");
//     }
//   } catch (e) {
//     print("API Client is not working. Connectivity test failed. Error: $e");
//   }
// }