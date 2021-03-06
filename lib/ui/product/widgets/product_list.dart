import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/extensions/string_extension.dart';
import 'package:fruity/models/product/product.dart';
import 'package:fruity/routes.dart';
import 'package:fruity/stores/category/category_store.dart';
import 'package:fruity/stores/category/product_store.dart';
import 'package:fruity/ui/product/product_detail_screen.dart';
import 'package:fruity/utils/currency_util.dart';
import 'package:fruity/widgets/add_to_cart_button.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryStore _categoryStore = context.read<CategoryStore>();

    return Observer(
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topLeft,
              color: Colors.white,
              margin: const EdgeInsets.only(left: 1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${_categoryStore.productStore.products.length} sản phẩm"),
                      PopupMenuButton(
                          child: Row(
                            children: [
                              Text(
                                _categoryStore.productStore.sortProduct.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const Icon(
                                Icons.swap_vert,
                                size: 15,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          onSelected: (SortProduct result) {
                            _categoryStore.productStore.setSortProduct(result);
                          },
                          itemBuilder: (BuildContext context) {
                            return List.generate(
                                _categoryStore.productStore.sortProducts.length,
                                (int index) {
                              SortProduct sortProduct = _categoryStore
                                  .productStore.sortProducts[index];

                              return PopupMenuItem(
                                value: sortProduct,
                                child: Text(sortProduct.name),
                              );
                            });
                          })
                    ]),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 1),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Skeleton(
                  isLoading: _categoryStore.productStore.loading,
                  skeleton: const _ProductListSkeleton(),
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    itemCount:
                        _categoryStore.productStore.sortedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product =
                          _categoryStore.productStore.sortedProducts[index];
                      return _ProductItem(product: product);
                    },
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;
  const _ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        Navigator.pushNamed(context, Routes.product_detail,
            arguments: ProductDetailAgruments(product.id));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox.fromSize(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name.trim().capitalize(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (product.packs.isNotEmpty)
                              Text(
                                product.packs.join('/').capitalize(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              )
                            else
                              Text(
                                (product.unit ?? '').capitalize(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${CurrencyHelper.withCommas(value: product.price, removeDecimal: true)}  ₫',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.palette.shade500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '/ ${product.unit}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (product.oldPrice != null &&
                                product.oldPrice! > 0)
                              Text(
                                '${CurrencyHelper.withCommas(value: product.oldPrice ?? 0, removeDecimal: true)}  ₫',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: AddToCartButton(
              product: product,
            ),
          )
        ],
      ),
    );
  }
}

class _ProductListSkeleton extends StatelessWidget {
  const _ProductListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
        height: 1,
      ),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: 80,
                  width: 80,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SkeletonParagraph(
                      style: const SkeletonParagraphStyle(
                        lines: 1,
                        lineStyle: SkeletonLineStyle(
                          height: 10,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 10,
                        width: 120,
                      ),
                    ),
                  ),
                  SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 10,
                        width: 80,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
