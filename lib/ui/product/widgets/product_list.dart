import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/models/product/product.dart';
import 'package:fruity/stores/category/category_store.dart';
import 'package:fruity/utils/money.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryStore _categoryStore = context.read<CategoryStore>();

    return Observer(
      builder: (BuildContext context) {
        return Skeleton(
          isLoading: _categoryStore.productStore.loading,
          skeleton: const _ProductListSkeleton(),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 1,
              height: 1,
            ),
            itemCount: _categoryStore.productStore.products.length,
            itemBuilder: (BuildContext context, int index) {
              final Product product =
                  _categoryStore.productStore.products[index];
              return _ProductItem(product: product);
            },
          ),
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
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        print('navigate to product dettail');
      },
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
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
                child: Container(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: product.packs.isNotEmpty
                                ? Text(
                                    product.packs.join('/'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${CurrencyHelper.withCommas(value: product.price, removeDecimal: true)}  đ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.palette.shade500),
                            ),
                            TextSpan(
                              text: "/ ${product.unit}",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              print('add to cart');
            },
            icon: Icon(
              Icons.add_circle,
              size: 30,
              color: AppColors.palette.shade500,
            ),
          ),
        )
      ]),
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
        return Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 10,
                        width: 150,
                      )),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 10,
                        width: 150,
                      )),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      lineStyle: SkeletonLineStyle(
                        height: 10,
                        width: 100,
                      )),
                ),
              ],
            )
          ]),
        );
      },
    );
  }
}