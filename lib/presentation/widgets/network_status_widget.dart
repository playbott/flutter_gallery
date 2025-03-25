import 'package:flutter/material.dart';
import 'package:photo_gallery/bloc/bloc.dart';

class NetworkStatusWidget extends StatelessWidget {
  const NetworkStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
      bloc: networkStatusBloc,
      builder: (context, state) {
        bool isOnline = state is NetworkStatusOnline;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isOnline ? Colors.green.withAlpha(200) : Colors.red.withAlpha(200),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOnline ? Icons.wifi : Icons.wifi_off,
                color: Colors.white,
                size: 16.0,
              ),
              const SizedBox(width: 4.0),
              Text(
                isOnline ? 'Online' : 'Offline',
                style: const TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ],
          ),
        );
      },
    );
  }
}