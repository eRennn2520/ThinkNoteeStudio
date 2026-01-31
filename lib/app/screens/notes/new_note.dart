import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/screens/notes/note_provider.dart';
import 'package:thinknotestudioapp/app/widgets/bottom_nav_bar.dart';
import 'package:thinknotestudioapp/app/widgets/slider_button.dart';
import 'package:provider/provider.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  bool _reminderEnabled = false; // State for the switch
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    var screenWidth = screenSize.size.width;
    var screenHeight = screenSize.size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/calendar.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.09),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  EvaIcons.arrowIosBack,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(
                                EvaIcons.calendar,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 28,
                          backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1633113214698-485cdb2f56fd?q=80&w=1974&auto=format&fit=crop",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Not\nDetayları",
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Task Title TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Başlık",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Task Description TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    hintText: "Açıklama",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3, // Allow multiple lines for description
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              Spacer(),
              RotatingSliderButton(
                onSlideCompleted: () {
                  final noteProvider = context.read<NoteProvider>();

                  noteProvider.addNote(
                    title: _titleController.text,
                    content: _descController.text,
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => RollingNavBar()),
                    (route) => false, // tüm route'ları temizler
                  );
                },
                text: 'Oluştur',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
