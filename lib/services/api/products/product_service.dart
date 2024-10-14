import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:getx_demo_app/services/app_exception.dart';
import 'package:http/http.dart' as http;

import '../../../models/product/product_model.dart';

class ProductService {
  static Future<Either<AppExceptions, List<ProductModel>>>
      fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> productList = json.decode(response.body);
        return Right(
            productList.map((json) => ProductModel.fromMap(json)).toList());
      }

      return Left(InternalServerErrorException());
    } on SocketException catch (_) {
      return Left(ConnectionLostException());
    } on Exception catch (_) {
      return Left(InternalServerErrorException());
    }
  }
}
