import 'package:animate_do/animate_do.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:thinknotestudioapp/app/screens/calendar/calendar_screen.dart';
import 'package:provider/provider.dart';
import 'package:thinknotestudioapp/app/screens/notes/new_note.dart';
import 'package:thinknotestudioapp/app/screens/notes/note_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Günaydın ☀️";
    } else if (hour >= 12 && hour < 18) {
      return "İyi günler 🌤️";
    } else if (hour >= 18 && hour < 22) {
      return "İyi akşamlar 🌙";
    } else {
      return "İyi geceler 🌌";
    }
  }

  final List<List<Color>> taskGradients = [
    [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
    [Color(0xFFFF9966), Color(0xFFFF5E62)],
    [Color(0xFF56ab2f), Color(0xFFA8E063)],
    [Color(0xFF614385), Color(0xFF516395)],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  radius: 28,
                                  backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1633113214698-485cdb2f56fd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getGreeting(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Text(
                                      "Sizin için buradayız ✨",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Arama butonu
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSearching = !_isSearching;
                                    _searchQuery = '';
                                    _searchController.clear();
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Icon(
                                    _isSearching
                                        ? EvaIcons.close
                                        : EvaIcons.search,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Artı butonu
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewNoteScreen(),
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

                // Search TextField (minimal)
                if (_isSearching)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 4,
                    ),
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16,
                            color: Colors.black45,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 32,
                            minHeight: 50,
                          ),
                          hintText: "Ara",
                          hintStyle: TextStyle(fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.01),
                // Başlık metni
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FadeInUp(
                      child: Text(
                        "Note Studio’na\nHoş geldin✨",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.25,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                Expanded(
                  child: Consumer<NoteProvider>(
                    builder: (context, noteProvider, _) {
                      final notes = noteProvider.notes
                          .where(
                            (n) =>
                                _searchQuery.isEmpty ||
                                n.title.toLowerCase().contains(_searchQuery),
                          )
                          .toList();

                      if (notes.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight * 0.06),
                              Lottie.asset(
                                "assets/Cute bear dancing.json",
                                width: screenWidth * 0.6,
                              ),
                              const Text(
                                "Henüz not yok",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          final gradient =
                              taskGradients[index % taskGradients.length];

                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(
                                      0.35,
                                    ),
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: const EdgeInsets.all(20),
                                        child: Center(
                                          child: Container(
                                            width: 360,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                              gradient: LinearGradient(
                                                colors: gradient,
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  blurRadius: 30,
                                                  offset: const Offset(0, 12),
                                                ),
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                        24,
                                                        24,
                                                        24,
                                                        20,
                                                      ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        note.title,
                                                        style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      Expanded(
                                                        child: SingleChildScrollView(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          child: Text(
                                                            note
                                                                    .content
                                                                    .isNotEmpty
                                                                ? note.content
                                                                : "Bu not boş.",
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white70,
                                                                  height: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 14,
                                                  right: 14,
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.of(
                                                      context,
                                                    ).pop(),
                                                    child: Container(
                                                      width: 34,
                                                      height: 34,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.25),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: SizedBox(
                                  height: 110,
                                  width: double.infinity,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: gradient,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: gradient.last.withOpacity(
                                            0.35,
                                          ),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (note.content.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            note.content,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    final provider = context
                                        .read<NoteProvider>();
                                    final index = provider.notes.indexOf(note);
                                    if (index != -1) {
                                      provider.deleteNote(index);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "Notu sil",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
