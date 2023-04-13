import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingBubble extends StatelessWidget {
  const LoadingBubble({
    Key? key,
    required this.status,
  }) : super(key: key);
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status == Status.loading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(80),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: JumpingDotsProgressIndicator(
                      dotSpacing: 1.5,
                      milliseconds: 100,
                      numberOfDots: 5,
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                backgroundImage: AssetImage('assets/images/computer.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
