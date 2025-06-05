import 'package:animate_do/animate_do.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thinknotestudioapp/app/screens/calendar/calendar_screen.dart';
import 'package:thinknotestudioapp/app/screens/home/all_screen.dart';
import 'package:thinknotestudioapp/app/screens/home/in_progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    ); // 3 tabs: All, In Progress, On Hold
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          child: FadeIn(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.09),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Container(
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: FadeInUp(
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
                                child: Icon(
                                  EvaIcons.search,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Artı butonu
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CalendarScreen(),
                                    ),
                                  );
                                },

                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons.add,
                                    color: Colors.black,
                                    size: 19,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Başlık metni
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FadeInUp(
                      child: Text(
                        "Manage Your\nDaily Tasks",
                        textAlign: TextAlign.left, // <--- BU DA ÖNEMLİ
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // TabBar for All, In Progress, On Hold
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors
                            .transparent, // indicator rengini transparent yapıyoruz, çünkü arka planı biz kendimiz ayarlayacağız
                      ),
                      labelColor: Colors
                          .white, // labelColor ve unselectedLabelColor burada etki etmeyecek, çünkü Text widget'larında renkleri kendimiz veriyoruz
                      unselectedLabelColor: Colors.black,
                      dividerColor: Colors.transparent,
                      tabs: List.generate(3, (index) {
                        bool isSelected = _tabController.index == index;

                        return Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                          child: Tab(
                            child: index == 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "All",
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.grey,
                                        child: Text(
                                          "03",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    index == 1 ? "In Progress" : "On Hold",
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                          ),
                        );
                      }),
                      onTap: (index) {
                        setState(() {
                          _tabController.index = index;
                        });
                      },
                    ),
                  ),
                ),

                // TabBarView remains unchanged
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                    AllScreen(),
                    
                   InProgressScreen(),
                   
                      Center(child: Text("On Hold Tasks")),
                    ],
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
