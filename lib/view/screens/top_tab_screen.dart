import 'package:assignment1/view/widgets/top_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:assignment1/controller/api_service.dart';
import 'package:assignment1/model/top_model.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  List<Deal> deals = [];
  bool isLoading = false;
  bool isRefreshing = false;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> fetchData({bool refresh = false}) async {
    if (!refresh) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isRefreshing = true;
      });
    }

    try {
      final fetchedDeals = await ApiService.fetchTopDeals(page: currentPage);
      setState(() {
        if (refresh) {
          deals.clear();
        }
        deals.addAll(fetchedDeals);
        isLoading = false;
        isRefreshing = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
        isRefreshing = false;
      });
    }
  }

  Future<void> _refreshData() async {
    currentPage = 1;
    await fetchData(refresh: true);
  }

  Future<void> _loadMoreData() async {
    if (!isLoading && !isRefreshing) {
      setState(() {
        isLoading = true;
      });
      currentPage++;
      try {
        final fetchedDeals = await ApiService.fetchTopDeals(page: currentPage);
        setState(() {
          deals.addAll(fetchedDeals);
          isLoading = false;
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching data: $e');
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: isLoading && !isRefreshing && deals.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: deals.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == deals.length) {
                    return buildLoadMoreIndicator();
                  } else {
                    return buildDealCard(deals[index]);
                  }
                },
                controller: _scrollController,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
