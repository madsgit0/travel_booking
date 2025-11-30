import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/search_results_page.dart';
import '../widgets/traveler_selector.dart';
import '../models/user.dart';

class FlightSearchForm extends StatefulWidget {
  final Function(VoidCallback)? onPrefillReady;
  
  const FlightSearchForm({super.key, this.onPrefillReady});

  @override
  State<FlightSearchForm> createState() => _FlightSearchFormState();
}

class _FlightSearchFormState extends State<FlightSearchForm> {
  String _tripType = 'roundtrip';
  DateTime? _departDate;
  DateTime? _returnDate;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  List<String> _selectedTravelers = [];
  List<String> _aggregatedPreferences = [];
  bool _isEditingPreferences = false;

  @override
  void initState() {
    super.initState();
    widget.onPrefillReady?.call(prefillFromEvent);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _updateAggregatedPreferences() {
    final allUsers = User.getMockUsers();
    final Set<String> uniquePreferences = {};
    
    for (var travelerName in _selectedTravelers) {
      final user = allUsers.firstWhere(
        (u) => u.name == travelerName,
        orElse: () => allUsers.first,
      );
      uniquePreferences.addAll(user.preferences);
    }
    
    setState(() {
      _aggregatedPreferences = uniquePreferences.toList();
      _isEditingPreferences = false;
    });
  }

  void prefillFromEvent() {
    setState(() {
      _fromController.text = 'Bari';
      _toController.text = 'Milano';
      _departDate = DateTime(2024, 12, 1);
      _returnDate = DateTime(2024, 12, 4);
      _selectedTravelers = ['Marco Rossi', 'Giulia Bianchi', 'Luca Esposito', 'Sofia Romano'];
      _updateAggregatedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: isMobile 
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 20)
              : const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio buttons per tipo di viaggio
              Row(
                children: [
                  _buildRadioOption('Andata e ritorno', 'roundtrip'),
                  const SizedBox(width: 24),
                  _buildRadioOption('Solo andata', 'oneway'),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // From/To inputs
              if (isMobile)
                Column(
                  children: [
                    _buildLocationInput('Da', Icons.flight_takeoff, _fromController),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.swap_vert,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLocationInput('A', Icons.flight_land, _toController),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildLocationInput('Da', Icons.flight_takeoff, _fromController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.swap_horiz,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildLocationInput('A', Icons.flight_land, _toController),
                    ),
                  ],
                ),
              
              const SizedBox(height: 16),
              
              // Date pickers
              if (isMobile)
                Column(
                  children: [
                    _buildDatePicker('Partenza', _departDate, (date) {
                      setState(() {
                        _departDate = date;
                      });
                    }),
                    const SizedBox(height: 16),
                    _buildDatePicker('Ritorno', _returnDate, (date) {
                      setState(() {
                        _returnDate = date;
                      });
                    }),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker('Partenza', _departDate, (date) {
                        setState(() {
                          _departDate = date;
                        });
                      }),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDatePicker('Ritorno', _returnDate, (date) {
                        setState(() {
                          _returnDate = date;
                        });
                      }),
                    ),
                  ],
                ),
              
              const SizedBox(height: 16),
              
              // Preferenze aggregate
              if (_aggregatedPreferences.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _aggregatedPreferences.map((pref) {
                        return _isEditingPreferences
                            ? Chip(
                                label: Text(
                                  pref,
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () {
                                  setState(() {
                                    _aggregatedPreferences.remove(pref);
                                  });
                                },
                                backgroundColor: Colors.blue.shade50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(color: Colors.blue.shade200),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.blue.shade200),
                                ),
                                child: Text(
                                  pref,
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isEditingPreferences = !_isEditingPreferences;
                        });
                      },
                      child: Text(
                        _isEditingPreferences ? 'Fine modifica' : 'Modifica le preferenze',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              
              // Chip viaggiatori selezionati
              if (_selectedTravelers.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Viaggiatori selezionati:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFE7F2D),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_selectedTravelers.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedTravelers.map((traveler) {
                        return Chip(
                          avatar: CircleAvatar(
                            backgroundColor: const Color(0xFFFE7F2D).withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: const Color(0xFFFE7F2D),
                            ),
                          ),
                          label: Text(
                            traveler,
                            style: const TextStyle(fontSize: 13),
                          ),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() {
                              _selectedTravelers.remove(traveler);
                              _updateAggregatedPreferences();
                            });
                          },
                          backgroundColor: Colors.grey.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              
              // Link aggiungi viaggiatore e pulsante cerca
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        showTravelerSelector(context, (user) {
                          setState(() {
                            if (!_selectedTravelers.contains(user.name)) {
                              _selectedTravelers.add(user.name);
                              _updateAggregatedPreferences();
                            }
                          });
                        });
                      },
                      icon: Icon(Icons.person_add_outlined, size: 18, color: Colors.grey.shade600),
                      label: Text(
                        _selectedTravelers.isEmpty 
                            ? 'Aggiungi un viaggiatore'
                            : 'Aggiungi altro viaggiatore',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultsPage(
                              from: _fromController.text.isEmpty ? 'Milano' : _fromController.text,
                              to: _toController.text.isEmpty ? 'Roma' : _toController.text,
                              departDate: _departDate ?? DateTime.now().add(const Duration(days: 1)),
                              returnDate: _returnDate ?? DateTime.now().add(const Duration(days: 4)),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFE7F2D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text('Scopri la tua soluzione'),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        showTravelerSelector(context, (user) {
                          setState(() {
                            if (!_selectedTravelers.contains(user.name)) {
                              _selectedTravelers.add(user.name);
                              _updateAggregatedPreferences();
                            }
                          });
                        });
                      },
                      icon: Icon(Icons.person_add_outlined, size: 18, color: Colors.grey.shade600),
                      label: Text(
                        _selectedTravelers.isEmpty 
                            ? 'Aggiungi un viaggiatore'
                            : 'Aggiungi altro viaggiatore',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultsPage(
                              from: _fromController.text.isEmpty ? 'Milano' : _fromController.text,
                              to: _toController.text.isEmpty ? 'Roma' : _toController.text,
                              departDate: _departDate ?? DateTime.now().add(const Duration(days: 1)),
                              returnDate: _returnDate ?? DateTime.now().add(const Duration(days: 4)),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFE7F2D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text('Scopri la tua soluzione'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _tripType,
          onChanged: (newValue) {
            setState(() {
              _tripType = newValue!;
            });
          },
          activeColor: Colors.black,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInput(String label, IconData icon, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
            hintText: label,
            hintStyle: TextStyle(color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today, size: 20, color: Colors.grey.shade600),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Text(
          selectedDate != null 
              ? DateFormat('dd/MM/yyyy').format(selectedDate)
              : label,
          style: TextStyle(
            fontSize: 14,
            color: selectedDate != null ? Colors.black : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

}
