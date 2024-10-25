import 'package:task/routes/url_constants.dart';

class ApiRoutes {
  String getProducts() {
    return "${UrlConstants.baseUrl}/items/product_list/realme-c30/?format=json";
  }
}
