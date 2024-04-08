import 'package:assignment1/view/widgets/feature_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:assignment1/controller/api_service.dart';
import 'package:assignment1/model/feature_model.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({Key? key}) : super(key: key);

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen> {
  late ScrollController _scrollController;
  late List<FeatureDeal> _featureDeals;
  bool _isLoading = false;
  int _page = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _featureDeals = [];
    _scrollController = ScrollController()..addListener(_scrollListener);
    _fetchFeatureDeals();
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
      _fetchFeatureDeals();
    }
  }

  Future<void> _fetchFeatureDeals() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        final List<FeatureDeal> fetchedDeals =
            await ApiService().fetchFeatureDeals(
          perPage: _perPage,
          page: _page,
        );
        setState(() {
          _featureDeals.addAll(fetchedDeals);
          _page++;
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching feature deals: $e');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshFeatureDeals() async {
    _page = 1;
    _featureDeals.clear();
    await _fetchFeatureDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        onRefresh: _refreshFeatureDeals,
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemCount: _featureDeals.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < _featureDeals.length) {
                  return buildFeatureDealItem(_featureDeals[index]);
                } else {
                  return const SizedBox();
                }
              },
            ),
            if (_isLoading && _featureDeals.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
