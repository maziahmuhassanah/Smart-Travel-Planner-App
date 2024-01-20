// cost_estimation.dart

import 'package:flutter/material.dart';

class CostEstimation {
  final String place;
  final String state;
  final String costEstimation; // Adjusted the variable name

  CostEstimation({
    required this.place,
    required this.state,
    required this.costEstimation,
  });
}

class CostEstimationCard extends StatelessWidget {
  final CostEstimation costEstimation;

  CostEstimationCard({required this.costEstimation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Place: ${costEstimation.place}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('State: ${costEstimation.state}'),
            Text('Cost: ${costEstimation.costEstimation}'),
          ],
        ),
      ),
    );
  }
}

class ViewEstimatedCostScreen extends StatelessWidget {
  final List<CostEstimation> costEstimations = [
    CostEstimation(place: 'Pasar Payang', state: 'Terengganu', costEstimation: 'Free entry'),
    CostEstimation(place: 'Masjid Kristal', state: 'Terengganu', costEstimation: 'Free entry'),
    CostEstimation(place: 'Pasar Siti Khadijah', state: 'Kelantan', costEstimation: 'Free entry'),
    CostEstimation(place: 'Wakaf Che Yeh', state: 'Kelantan', costEstimation: 'Free entry'),
    CostEstimation(
      place: 'Balai Cerap Bukit Kemang',
      state: 'Negeri Sembilan',
      costEstimation: 'RM25 (adult) / RM12 (kids under 12)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estimated Cost'),
      ),
      body: costEstimations.isEmpty
          ? Center(
              child: Text('No cost estimations available'),
            )
          : ListView.builder(
              itemCount: costEstimations.length,
              itemBuilder: (context, index) {
                return CostEstimationCard(costEstimation: costEstimations[index]);
              },
            ),
    );
  }
}
