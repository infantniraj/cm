import 'dart:convert';
import 'package:get/get.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/products_models.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  Future<void> getPopularProductList()async{
    try {
      Response response = await popularProductRepo.getPopularProductList();
      // dynamic responseData = response.body;
      // print('Response Data: $responseData');
      if(response.statusCode==200){
        print("got products");
        _popularProductList=[];
        _popularProductList.addAll(Product.fromJson(response.body).products);
       // print(_popularProductList);
        _isLoaded = true;
        update();
      }else{
        print("error messge");
      }
    }catch (error) {
      // Handle other errors (e.g., network issues)
      print("unexpected error: $error");
    }

  }
}