import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/models/search/product_simplify.dart';
import 'package:fruity/routes.dart';
import 'package:fruity/stores/search/search.dart';
import 'package:fruity/stores/search_history/search_history_store.dart';
import 'package:fruity/ui/product/product_detail_screen.dart';
import 'package:fruity/ui/search/search_result_screen.dart';
import 'package:fruity/utils/currency_util.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchHistoryStore _store;
  late SearchStore _searchStore;
  late FocusScopeNode currentFocus;
  Timer? _debounce;
  final List<String> _hotSearch = [
    'Dừa',
    'Cà chua',
    'Cà rốt',
    'Cà phê',
    'Cà tím',
    'Cà tỏi'
  ];
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _store = context.read<SearchHistoryStore>();
    _searchStore = context.read<SearchStore>();
    if (_searchStore.keyword.isNotEmpty) {
      _searchController.text = _searchStore.keyword;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);
    return Observer(
      builder: (_) {
        return SafeArea(
            child: Scaffold(
                body: CustomScrollView(slivers: <Widget>[
          SliverPinnedHeader(
            child: Column(
              children: [
                _header(),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            decoration: const BoxDecoration(color: AppColors.backgroudGrey),
            child: Column(
              children: [
                _searchProducts(),
                _historySearch(),
                _populateSearch(),
              ],
            ),
          )),
        ])));
      },
    );
  }

  Widget _searchProducts() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (_searchStore.keyword.isEmpty) {
      return Container();
    }
    int itemCount = _searchStore.products.length;
    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: _searchStore.loading
              ? Container(
                  height: height,
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(),
                  ),
                )
              : _searchStore.products.isEmpty
                  ? _emptySearch()
                  : SingleChildScrollView(
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemCount: itemCount,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final ProductSimplify _product =
                              _searchStore.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.product_detail,
                                  arguments:
                                      ProductDetailAgruments(_product.id));
                            },
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 15, 0, 15),
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                _product.imageUrl ??
                                                    "https://atpsoftware.vn/wp-content/uploads//2019/06/depositphotos_58810529-stock-illustration-product-concept.jpg",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 5, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _product.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                        '${CurrencyHelper.withCommas(
                                                      value: _product.price,
                                                      removeDecimal: true,
                                                    )}₫',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            ' / ${_product.unit}',
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )),
    );
  }

  Widget _historySearch() {
    if (_searchStore.keyword.isEmpty == false) {
      return Container();
    }
    final List<String> searchHistory = _store.searchs;
    if (searchHistory.isEmpty) {
      return Container();
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchHistory.length,
              itemBuilder: (BuildContext context, int index) {
                final String search =
                    searchHistory[searchHistory.length - 1 - index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        search,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      onTap: () {
                        _search(search);
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          _store.removeItem(search);
                        },
                      ),
                    ),
                    const Divider(
                      height: 1,
                      indent: 15,
                      endIndent: 15,
                      thickness: 1,
                      color: Color.fromARGB(108, 158, 158, 158),
                    ),
                  ],
                );
              },
            ),
            Align(
              child: TextButton(
                child: const Text(
                  'Xóa tất cả',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onPressed: () {
                  _store.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _populateSearch() {
    if (_searchStore.keyword.isEmpty == false) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 250,
      color: Colors.white,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/hot.png',
                    width: 50,
                  ),
                  const Text(
                    'Tìm kiếm phổ biến',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimationLimiter(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 3.4,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: 2,
                  children: List.generate(
                    _hotSearch.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: ScaleAnimation(
                          scale: 0.5,
                          child: FlipAnimation(
                            child: GestureDetector(
                              onTap: () {
                                _searchStore.keyword = _hotSearch[index];
                                _search(null);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.only(left: 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.backgroudGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(_hotSearch[index]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 70.0,
      child: Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.palette,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  height: 36.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: width * 0.8,
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: TextField(
                              key: Key('search_field'),
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tìm tên sản phẩm, nhà cung cấp',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                suffixIcon: IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.cancel_sharp,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _searchStore.keyword = '';
                                    _searchController.clear();
                                  },
                                ),
                              ),
                              onChanged: (String value) {
                                if (value == _searchStore.keyword) {
                                  return;
                                }
                                _searchStore.keyword = value;
                                if (_debounce?.isActive ?? false) {
                                  _debounce!.cancel();
                                }
                                _debounce = Timer(
                                    const Duration(milliseconds: 500), () {
                                  _searchStore.searchProduct(5);
                                });
                              },
                              onSubmitted: (String value) {
                                _search(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              key: Key('exit_search'),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Thoát',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _search(String? keyword) {
    if (keyword != null) {
      _searchStore.keyword = keyword;
    }
    final String search = _searchStore.keyword;
    if (search.isEmpty) {
      return;
    }
    _store.addItem(search);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SearchResultScreen(),
      ),
    );
  }
}

class _emptySearch extends StatelessWidget {
  const _emptySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/empty_search.png'),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
            const Text(
              'Không tìm thấy sản phẩm',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
