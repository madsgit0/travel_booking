import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/hero_section.dart';
import '../widgets/flight_search_form.dart';
import '../widgets/upcoming_events_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VoidCallback? _prefillCallback;

  void _handlePrefill() {
    _prefillCallback?.call();
  }

  void _setPrefillCallback(VoidCallback callback) {
    _prefillCallback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeroSection(onPrefill: _handlePrefill),
                  const SizedBox(height: 32),
                  FlightSearchForm(onPrefillReady: _setPrefillCallback),
                  const SizedBox(height: 48),
                  const UpcomingEventsSection(),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
