import 'package:flutter/material.dart';
import 'package:fruity/stores/category/category_store.dart';
import 'package:fruity/ui/product/widgets/category_carousel.dart';
import 'package:fruity/ui/product/widgets/header_product_screen.dart';
import 'package:fruity/ui/product/widgets/product_list.dart';
import 'package:fruity/ui/product/widgets/subcategory_carousel.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ProductScreenAppBar(),
      body: Provider<CategoryStore>(
        create: (_) => CategoryStore(),
        child: const _ProductScreenBody(),
      ),
    );
  }
}

class _ProductScreenBody extends StatefulWidget {
  const _ProductScreenBody({Key? key}) : super(key: key);

  @override
  State<_ProductScreenBody> createState() => __ProductScreenBodyState();
}

class __ProductScreenBodyState extends State<_ProductScreenBody> {
  late CategoryStore _categoryStore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryStore = context.read<CategoryStore>();
    _categoryStore.init();
    _categoryStore.setupUpdateParent();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CategoryCarousel(),
          Expanded(
            child: Row(
              children: const <Widget>[
                SubcategoryCarousel(),
                Expanded(
                  child: ProductList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
