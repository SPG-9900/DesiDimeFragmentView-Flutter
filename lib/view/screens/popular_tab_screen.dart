import 'package:assignment1/view/widgets/popular_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:assignment1/controller/api_service.dart';
import 'package:assignment1/model/popular_model.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  late ScrollController _scrollController;
  final List<PopularDeal> _popularDeals = [];
  bool _isLoading = false;
  int _page = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _fetchPopularDeals();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchPopularDeals();
    }
  }

  Future<void> _fetchPopularDeals() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        final List<PopularDeal> fetchedDeals =
            await ApiService().fetchPopularDeal(
          perPage: _perPage,
          page: _page,
        );
        setState(() {
          _popularDeals.addAll(fetchedDeals);
          _page++;
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching popular deals: $e');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshPopularDeals() async {
    _page = 1;
    _popularDeals.clear();
    await _fetchPopularDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refreshPopularDeals,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _popularDeals.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < _popularDeals.length) {
                  return buildDealItem(_popularDeals[index]);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          if (_isLoading && _popularDeals.isEmpty)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
