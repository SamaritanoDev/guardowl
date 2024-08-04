import 'package:flutter/material.dart';
import 'package:guardowl/features/discovery/widgets/search_container_button.dart';
import 'package:guardowl/features/share/sos_button.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // MapView here:
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/pass/GoogleMapTA.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  Expanded(child: SearchContainerButton()),
                  SizedBox(width: 10),
                  SosButton(),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
