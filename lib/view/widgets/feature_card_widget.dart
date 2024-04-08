import 'package:flutter/material.dart';
import 'package:assignment1/model/feature_model.dart';

Widget buildFeatureDealItem(FeatureDeal deal) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    child: Card(
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
