import 'package:flutter/material.dart';
import 'package:assignment1/model/popular_model.dart';

Widget buildDealItem(PopularDeal deal) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    child: Card(
      color: Colors.white,
      child: ListTile(
        leading: Image.network(
          deal.imageMedium,
          width: 80,
          height: 80,
        ),
        title: Text(deal.store?.name ?? 'Unknown Store'),
        subtitle: Row(
          children: [
            const Icon(Icons.comment),
            const SizedBox(width: 4),
            Text('${deal.commentsCount}'),
          ],
        ),
      ),
    ),
  );
}
