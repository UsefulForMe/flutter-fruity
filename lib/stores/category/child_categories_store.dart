import 'package:dio/dio.dart';
import 'package:fruity/data/network/apis/cateory/category_api.dart';
import 'package:fruity/data/network/dio_client.dart';
import 'package:fruity/dto/category/category_request.dart';
import 'package:fruity/dto/category/category_response.dart';
import 'package:fruity/models/category/category.dart';
import 'package:mobx/mobx.dart';

part 'child_categories_store.g.dart';

class ChildCategoryStore = _ChildCategoryStoreBase with _$ChildCategoryStore;

abstract class _ChildCategoryStoreBase with Store {
  final CategoryAPI _categoryAPI = CategoryAPI(DioClient(Dio()));

  @observable
  List<Category> categories = [];

  @observable
  bool loading = true;

  @observable
  String? errorMessage;

  @action
  Future<void> getCategories(Category category) async {
    try {
      loading = true;
      final CategoryListResponse res = await _categoryAPI.getChildCategories(
        CategoryListRequest(query: {'parent_id': category.id}),
      );

      if (res.errorMessage != null) {
        errorMessage = res.errorMessage;
      } else {
        categories = res.categories;
      }
    } catch (err) {
      errorMessage = err.toString();
    } finally {
      loading = false;
    }
  }
}
