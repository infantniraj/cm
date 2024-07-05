import 'dart:convert';
import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/products_models.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;


  Future<void> getRecommendedProductList()async{
    try {
      Response response = await recommendedProductRepo.getRecommendedProductList();
      // dynamic responseData = response.body;
      // print('Response Data: $responseData');
      if(response.statusCode==200){
        print("got products recommended");
        _recommendedProductList=[];
        _recommendedProductList.addAll(Product.fromJson(response.body).products);
        // print(_recommendedProductList);
        _isLoaded = true;
        update();
      }else{
        print("else got products recommended");
      }
    }catch (error) {
      // Handle other errors (e.g., network issues)
      print("unexpected error: $error");
    }

  }
}