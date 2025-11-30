import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchFiltersBar extends StatelessWidget {
  final String from;
  final String to;
  final DateTime departDate;
  final DateTime returnDate;

  const SearchFiltersBar({
    super.key,
    required this.from,
    required this.to,
    required this.departDate,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM', 'it_IT');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tipo viaggio dropdown
          Row(
            children: [
              Text(
                'Andata e ritorno',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          
          // Campi ricerca
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;
              
              if (isMobile) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: _buildSearchInput(Icons.flight_takeoff, from),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.swap_horiz, color: Colors.grey.shade400),
                      ),
                      SizedBox(
                        width: 160,
                        child: _buildSearchInput(Icons.flight_land, to),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 130,
                        child: _buildSearchInput(Icons.calendar_today, dateFormat.format(departDate), isDate: true),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 130,
                        child: _buildSearchInput(Icons.calendar_today, dateFormat.format(returnDate), isDate: true),
                      ),
                    ],
                  ),
                );
              }
              
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildSearchInput(Icons.flight_takeoff, from),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.swap_horiz, color: Colors.grey.shade400),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildSearchInput(Icons.flight_land, to),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(child: _buildSearchInput(Icons.calendar_today, dateFormat.format(departDate), isDate: true)),
                        const SizedBox(width: 8),
                        Expanded(child: _buildSearchInput(Icons.calendar_today, dateFormat.format(returnDate), isDate: true)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Filtri chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Tariffa (2)'),
                _buildFilterChip('Policy'),
                _buildFilterChip('Orari'),
                _buildFilterChip('Scali'),
                _buildFilterChip('Compagnie (4)'),
                _buildFilterChip('Aeroporti (1)'),
                _buildFilterChip('Durata'),
                const SizedBox(width: 16),
                Text(
                  'Reimposta filtri',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput(IconData icon, String text, {bool isDate = false}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isDate) ...[
            Icon(Icons.chevron_left, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          if (label.startsWith('Tariffa')) ...[
            Icon(Icons.airplane_ticket_outlined, size: 14),
            const SizedBox(width: 4),
          ] else if (label.startsWith('Policy')) ...[
            Icon(Icons.shield_outlined, size: 14),
            const SizedBox(width: 4),
          ] else if (label.startsWith('Orari')) ...[
            Icon(Icons.access_time, size: 14),
            const SizedBox(width: 4),
          ] else if (label.startsWith('Scali')) ...[
            Icon(Icons.graphic_eq, size: 14), 
            const SizedBox(width: 4),
          ] else if (label.startsWith('Compagnie')) ...[
            Icon(Icons.airlines, size: 14),
            const SizedBox(width: 4),
          ] else if (label.startsWith('Aeroporti')) ...[
            Icon(Icons.flight, size: 14),
            const SizedBox(width: 4),
          ] else if (label.startsWith('Durata')) ...[
            Icon(Icons.filter_list, size: 14),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 14),
        ],
      ),
    );
  }
}
