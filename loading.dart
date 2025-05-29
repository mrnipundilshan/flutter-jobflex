import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _progressAnimation;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Create animation for the progress indicator value
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Timer for updating the dots
    Future.delayed(const Duration(milliseconds: 500), _updateDots);
  }

  void _updateDots() {
    if (mounted) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // Cycle between 0-3 dots
      });
      Future.delayed(const Duration(milliseconds: 500), _updateDots);
    }
  }

  String get _loadingText {
    String dots = '';
    for (int i = 0; i < _dotCount; i++) {
      dots += '.';
    }
    return 'Loading$dots';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA), // Light blue-gray background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated CircularProgressIndicator
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 12,
                    value: null, // This makes it continuously animate
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF1F3A63)),
                    backgroundColor: const Color(0xFFB8C4D9),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            // Animated Loading... text
            Text(
              _loadingText,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F3A63), // Dark blue text
                fontFamily: 'Arial', // You can change to your app's font
              ),
            ),
            const SizedBox(height: 10),
            // Please wait text
            const Text(
              'Please wait',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFFB8C4D9), // Light blue-gray text
                fontFamily: 'Arial', // You can change to your app's font
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative implementation with a simulated loading progress:
// If you want to simulate actual loading progress, uncomment and use this class instead

/*
class SimulatedLoadingPage extends StatefulWidget {
  const SimulatedLoadingPage({super.key});

  @override
  State<SimulatedLoadingPage> createState() => _SimulatedLoadingPageState();
}

class _SimulatedLoadingPageState extends State<SimulatedLoadingPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _dotsController;
  late Animation<double> _progressAnimation;
  int _dotCount = 0;
  
  @override
  void initState() {
    super.initState();
    
    // For the progress indicator
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // Total loading time
    )..forward();
    
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    
    // For the dots animation
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    _dotsController.addListener(() {
      if (mounted) {
        setState(() {
          _dotCount = (_dotsController.value * 4).floor() % 4;
        });
      }
    });
    
    // Navigate to next screen when loading is complete
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to your home screen or main app
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => YourHomeScreen()),
        // );
      }
    });
  }
  
  String get _loadingText {
    String dots = '';
    for (int i = 0; i < _dotCount; i++) {
      dots += '.';
    }
    return 'Loading$dots';
  }
  
  @override
  void dispose() {
    _progressController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress indicator that shows actual progress
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 12,
                    value: _progressAnimation.value,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1F3A63)),
                    backgroundColor: const Color(0xFFB8C4D9),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            // Animated Loading... text
            Text(
              _loadingText,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F3A63),
                fontFamily: 'Arial',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please wait',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFFB8C4D9),
                fontFamily: 'Arial',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
