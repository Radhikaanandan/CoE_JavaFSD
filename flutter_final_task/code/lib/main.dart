import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'book_screen.dart'; 
import 'news_screen.dart'; 
import 'quotes_screen.dart'; 
import 'space_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogin = true;

  Future<void> handleAuth() async {
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
      
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "email": emailController.text.trim(),
          "created_at": FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? "Login" : "Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleAuth,
              child: Text(isLogin ? "Login" : "Sign Up"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin ? "Don't have an account? Sign Up" : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    return await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No user data found."));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String userName = userData['name'] ?? "User";
          String userEmail = userData['email'] ?? "No Email";
          String userProfile = userData['profilePic'] ?? ""; 

          return Column(
            children: [
             
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
      radius: 40,
      backgroundColor: Colors.blueGrey[100],
      child: Icon(Icons.person, size: 40, color: Colors.grey[700]), 
    ),
    SizedBox(width: 16),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to InfoTimepass!!",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userEmail,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    FeatureCard(
                      title: "📚 Search Books",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookScreen())),
                    ),
                    FeatureCard(
                      title: "📰 Latest News",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen())),
                    ),
                    FeatureCard(
                      title: "💡 Get Motivation",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuotesScreen())),
                    ),
                    FeatureCard(
                      title: "🌌 Space Facts",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SpaceScreen())),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  FeatureCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}