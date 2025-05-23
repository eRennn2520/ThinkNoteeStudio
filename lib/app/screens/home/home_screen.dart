import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    var screenWidth = screenSize.size.width;
    var screenHeight = screenSize.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"), // Arka plan resmi
              fit: BoxFit.cover,
            ),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             SizedBox(height: screenHeight * 0.09,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Profil fotoğrafı
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          
            radius: 28,
            backgroundImage: NetworkImage(
              
              "https://images.unsplash.com/photo-1633113214698-485cdb2f56fd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
          
                      ),
                      // Arama butonu
                      Row(
                        children: [
                          CircleAvatar(
                            
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(EvaIcons.search, color: Colors.black),
                          ),
                          const SizedBox(width: 10),
                          // Artı butonu
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(FontAwesomeIcons.add, color: Colors.black,size: 19,),
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
