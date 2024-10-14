import 'package:get/get.dart';
import 'package:getx_demo_app/models/common/api_response.dart';
import 'package:getx_demo_app/models/product/product_model.dart';
import 'package:getx_demo_app/services/api/products/product_service.dart';

typedef ProductAPIResponse = APIResponse<List<ProductModel>>;

class ProductController extends GetxController {
  final _productsData = Rx<ProductAPIResponse>(APIResponse.initial());
  ProductAPIResponse get productsData => _productsData.value;

  int get totalItems => _productsData.value.data?.length ?? 0;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    _productsData(APIResponse.loading());
    final productsList = await ProductService.fetchProducts();
    productsList.fold((error) {
      _productsData(APIResponse.error(error.message, exception: error));
    }, (productsList) {
      _productsData(APIResponse.completed(List.from(productsList)));
    });
  }
}
