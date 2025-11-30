import 'package:flutter/material.dart';

void showFlightAlternatives(BuildContext context, String type) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Alternative per $type',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFlightOption(
              'EasyJet',
              'assets/images/easyjet.png',
              '07:00',
              '08:30',
              '€55',
            ),
            _buildFlightOption(
              'ITA Airways',
              'assets/images/ita.png',
              '09:15',
              '10:25',
              '€89',
            ),
            _buildFlightOption(
              'Ryanair',
              'assets/images/ryanair.png',
              '18:45',
              '20:15',
              '€42',
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFlightOption(String airline, String logo, String dep, String arr, String price) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Image.asset(logo, width: 32, height: 32),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(airline, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('$dep - $arr', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        ),
        Text(
          price,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFE7F2D)),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('Seleziona'),
        ),
      ],
    ),
  );
}

void showHotelAlternatives(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alternative Hotel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHotelOption(
              'Hotel Palazzo Reale',
              'assets/images/hotel_alt_1.jpg',
              '4.5',
              '€145',
            ),
            _buildHotelOption(
              'Grand Hotel Milano',
              'assets/images/hotel_alt_2.jpg',
              '4.0',
              '€110',
            ),
            _buildHotelOption(
              'Urban Design Hotel',
              'assets/images/hotel_alt_3.jpg',
              '4.8',
              '€180',
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildHotelOption(String name, String image, String rating, String price) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: Color(0xFFFE7F2D)),
                  const SizedBox(width: 4),
                  Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$price /notte',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFE7F2D)),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Seleziona'),
            ),
          ],
        ),
      ],
    ),
  );
}
