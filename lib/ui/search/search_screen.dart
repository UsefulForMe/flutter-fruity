import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/models/search/product_simplify.dart';
import 'package:fruity/ui/personal/widgets/personal_header.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // late SearchHistoryStore _store;
  // late SearchStore _searchStore;
  // late FocusScopeNode currentFocus;
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
    // _store = context.read<SearchHistoryStore>();
    // _searchStore = context.read<SearchStore>();
    // if (_searchStore.keyword.isNotEmpty) {
    //   _searchController.text = _searchStore.keyword;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // currentFocus = FocusScope.of(context);
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
                _list(),
              ],
            ),
          )),
        ])));
      },
    );
  }


  Widget _list() {
    // if (_searchStore.keyword.isEmpty == false) {
    //   return Container();
    // }
    // final List<String> searchHistory = _store.searchs;
    // if (searchHistory.isEmpty) {
    //   return Container();
    // }
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                // final String search =
                //     searchHistory[searchHistory.length - 1 - index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              imageUrl:
                                  "https://atpsoftware.vn/wp-content/uploads//2019/06/depositphotos_58810529-stock-illustration-product-concept.jpg",
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Teacher 1",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              String url = 'tel:0712365489';
                              launchUrlString(url);
                            },
                            child: Text("0712365489")),

                      ],
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
                                hintText: 'Search by teacher name or class',
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
                                    // _searchStore.keyword = '';
                                    _searchController.clear();
                                  },
                                ),
                              ),
                              onChanged: (String value) {
                                // if (value == _searchStore.keyword) {
                                //   return;
                                // }
                                // _searchStore.keyword = value;
                                if (_debounce?.isActive ?? false) {
                                  _debounce!.cancel();
                                }
                                _debounce = Timer(
                                    const Duration(milliseconds: 500), () {
                                  // _searchStore.searchProduct(5);
                                });
                              },
                              onSubmitted: (String value) {
                                // _search(value);
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
          ],
        ),
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
