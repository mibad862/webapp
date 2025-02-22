import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(PhishGuardApp());
}

class PhishGuardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhishGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _url = '';
  String _result = '';
  bool _isLoading = false;

  void _checkPhishing() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _result = _url.contains('phish') ? 'Phishing Website' : 'Safe Website';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Gradient
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PhishGuard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Tools',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'About',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Contact',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hero Section with Gradient
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Phishing URL Checker',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                  SizedBox(height: 10),
                  Text(
                    'Enter a URL to check if it\'s safe or phishing',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.5),
                  SizedBox(height: 40),
                  Container(
                    width: 600,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter URL to check...',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _url = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _checkPhishing,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Colors.blue.shade900,
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                            'Check',
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.5),
                ],
              ),
            ),

            // Features Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Why Choose PhishGuard?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                  SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.security,
                        title: 'Advanced Security',
                        description:
                        'Uses cutting-edge algorithms to detect phishing websites.',
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.5),
                      _buildFeatureCard(
                        icon: Icons.speed,
                        title: 'Fast Results',
                        description:
                        'Get instant results with minimal waiting time.',
                      ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.5),
                      _buildFeatureCard(
                        icon: Icons.verified_user,
                        title: 'Reliable',
                        description: 'Trusted by thousands of users worldwide.',
                      ).animate().fadeIn(delay: 900.ms).slideY(begin: -0.5),
                      _buildFeatureCard(
                        icon: Icons.phone_android,
                        title: 'Cross-Platform',
                        description:
                        'Works seamlessly on all devices and platforms.',
                      ).animate().fadeIn(delay: 1100.ms).slideY(begin: -0.5),
                    ],
                  ),
                ],
              ),
            ),

            // How It Works Section with Gradient
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'How It Works',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStepCard(
                        step: '1',
                        title: 'Enter URL',
                        description:
                        'Enter the URL you want to check in the input field.',
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.5),
                      _buildStepCard(
                        step: '2',
                        title: 'Click Check',
                        description:
                        'Click the "Check" button to analyze the URL.',
                      ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.5),
                      _buildStepCard(
                        step: '3',
                        title: 'Get Results',
                        description:
                        'Receive instant feedback on whether the URL is safe or phishing.',
                      ).animate().fadeIn(delay: 900.ms).slideY(begin: -0.5),
                    ],
                  ),
                ],
              ),
            ),

            // Testimonials Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'What Our Users Say',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.5),
                  SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildTestimonialCard(
                        name: 'John Doe',
                        role: 'Security Analyst',
                        testimonial:
                        'PhishGuard has been a game-changer for our team. Highly recommended!',
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.5),
                      _buildTestimonialCard(
                        name: 'Jane Smith',
                        role: 'IT Manager',
                        testimonial:
                        'The tool is fast, reliable, and easy to use. Great job!',
                      ).animate().fadeIn(delay: 700.ms).slideY(begin: -0.5),
                    ],
                  ),
                ],
              ),
            ),

            // Footer with Gradient
            Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  '© 2023 PhishGuard. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      {required IconData icon,
        required String title,
        required String description}) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 50, color: Colors.blue.shade900),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(
      {required String step,
        required String title,
        required String description}) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade900,
            child: Text(
              step,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
      {required String name,
        required String role,
        required String testimonial}) {
    return Container(
      width: 400,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue.shade900,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 5),
          Text(
            role,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 20),
          Text(
            testimonial,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
