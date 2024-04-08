import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:assignment1/model/top_model.dart';

Widget buildDealCard(Deal deal) {
  final storeName = deal.store != null ? deal.store!.name : 'Unknown Store';
  final formattedDate = DateFormat.yMMMEd().format(deal.createdAt);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    child: Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.network(
                  deal.imageMedium,
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                'Store: $storeName',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.comment),
                const SizedBox(width: 4),
                Text('${deal.commentsCount}'),
                const SizedBox(width: 16),
                const Icon(Icons.access_time),
                const SizedBox(width: 4),
                Text(formattedDate),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildLoadMoreIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
