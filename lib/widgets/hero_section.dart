import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onPrefill;
  
  const HeroSection({super.key, required this.onPrefill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Text(
            'Ciao Marco, dove vuoi andare oggi?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Prossimo evento da',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 6),
              SvgPicture.asset(
                'assets/images/google_calendar.svg',
                height: 24,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.yellow.shade700.withOpacity(0.3)),
                ),
                child: Text(
                  'Fiera Milano',
                  style: TextStyle(
                    color: Colors.yellow.shade900,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onPrefill,
                child: Text(
                  'Precompila',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFFE7F2D),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
