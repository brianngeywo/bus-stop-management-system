import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_screen.dart';
import 'package:bus_sacco/validators.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  bool isSigninguUp = false;

  @override
  Widget build(BuildContext context) {
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
                  'Sign Up',
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
                      if (!validateName(value!)) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (!validateEmail(value!)) {
                        return 'Please enter a valid email address';
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
                        return 'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number and one special character';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isSigninguUp = true;
                    });
                    if (validateName(nameController.text) &&
                        validateEmail(emailController.text) &&
                        validatePassword(passwordController.text)) {
                      try {
                        await auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sign up successful',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          isSigninguUp = false;
                        });
                      } catch (e) {
                        setState(() {
                          isSigninguUp = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        isSigninguUp = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: isSigninguUp
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Navigation to login page
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have an account? Login',
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
