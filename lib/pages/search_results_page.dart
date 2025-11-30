import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/search_filters_bar.dart';
import '../widgets/package_cards.dart';
import '../widgets/alternative_dialogs.dart';

class SearchResultsPage extends StatelessWidget {
  final String from;
  final String to;
  final DateTime departDate;
  final DateTime returnDate;

  const SearchResultsPage({
    super.key,
    this.from = 'Milano',
    this.to = 'Roma',
    required this.departDate,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppHeader(),
          SearchFiltersBar(
            from: from,
            to: to,
            departDate: departDate,
            returnDate: returnDate,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 900;
                
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: isMobile
                      ? Column(
                          children: [
                            // Mobile Layout: Stacked
                            _buildFlightsColumn(context),
                            const SizedBox(height: 32),
                            _buildHotelsColumn(context),
                            const SizedBox(height: 32),
                            const PackageTotalCard(),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Desktop Layout: Side by side
                            Expanded(
                              flex: 3,
                              child: _buildFlightsColumn(context),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 4,
                              child: _buildHotelsColumn(context),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 3,
                              child: const PackageTotalCard(),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightsColumn(BuildContext context) {
    return Column(
      children: [
        FlightSummaryCard(
          label: 'ANDATA',
          date: '30 nov',
          departureTime: '14:15',
          arrivalTime: '15:50',
          departureAirport: 'BRI',
          arrivalAirport: 'BGY',
          duration: '1h 35',
          onAlternativesTap: () => showFlightAlternatives(context, 'Andata'),
        ),
        FlightSummaryCard(
          label: 'RITORNO',
          date: '3 dic',
          departureTime: '11:40',
          arrivalTime: '13:15',
          departureAirport: 'BGY',
          arrivalAirport: 'BRI',
          duration: '1h 35',
          onAlternativesTap: () => showFlightAlternatives(context, 'Ritorno'),
          marginBottom: 0,
        ),
        const SizedBox(height: 32),
        _buildPriceSummary('€105 a persona', '€420'),
      ],
    );
  }

  Widget _buildHotelsColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 282,
          child: HotelSummaryCard(
            onAlternativesTap: () => showHotelAlternatives(context),
          ),
        ),
        const SizedBox(height: 32),
        _buildPriceSummary('€123 a notte', '€492'),
      ],
    );
  }

  Widget _buildPriceSummary(String perUnit, String total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED), // Beige chiaro
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFE7F2D)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            perUnit,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Text(
                'tot. x4: ',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
