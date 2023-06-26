import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_screen.dart';
import 'package:bus_sacco/signup.dart';
import 'package:bus_sacco/validators.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isSigningIn = false;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 420.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to TranspoLink',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[900],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[900],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (!validateEmail(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (!validatePassword(value!)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (validateEmail(emailController.text) &&
                        validatePassword(passwordController.text)) {
                      setState(() {
                        isSigningIn = true;
                      });
                      try {
                        await auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()),
                                ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: const Text(
                                'Logged in successfully',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.cyan[900],
                              duration: const Duration(seconds: 2)),
                        );
                        setState(() {
                          isSigningIn = false;
                        });
                      } catch (e) {
                        setState(() {
                          isSigningIn = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                        ),
                      );
                      setState(() {
                        isSigningIn = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isSigningIn
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Navigation to sign up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
