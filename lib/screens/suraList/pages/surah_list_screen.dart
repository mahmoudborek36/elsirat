import 'package:elsirat/core/services%20copy/local.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/screens/suraList/widgets/drawer_menu_widgets.dart';
import 'package:elsirat/screens/verse_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/surah.dart';
import '../../../services/quran_service.dart';
import '../../verse_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  User? user;

  String searchText = '';
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<Surah> allSurahs = [];
  List<Surah> filteredSurahs = [];

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    getUser();

    lastSurahId = AppLocalStorageshared.getCachedData("last_surah_id");
    lastSurahName = AppLocalStorageshared.getCachedData("last_surah_name");
    lastVerseId = AppLocalStorageshared.getCachedData("last_verse_id");
  }

  String? lastSurahName;
  int? lastSurahId;
  int? lastVerseId;

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    setState(() {
      isSearching = false;
      searchText = '';
      searchController.clear();
      filteredSurahs = allSurahs;
    });
  }

  void filterSurahs(String value) {
    setState(() {
      searchText = value;
      filteredSurahs = allSurahs.where((s) {
        return s.name.contains(value) ||
            s.transliteration.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: AppColors.back,
        elevation: 0,
        backgroundColor: AppColors.greyColor,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(18),
              child: SvgPicture.asset("assets/icons/Vectormen.svg"),
            ),
          ),
        ),
        centerTitle: false,
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: filterSurahs,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                style: getbodyStyle(color: Colors.white),
              )
            : Text(
                "El-Sirat",
                style: getHeadlineTextStyle(),
              ),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.color1,
                  ),
                  onPressed: stopSearch,
                )
              : Container(
                  width: 180.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.contanierCoror),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppColors.color1,
                        ),
                        onPressed: startSearch,
                      ),
                    ],
                  ),
                ),
        ],
      ),
      drawer: drawerMenuWidgets(user: user),
      backgroundColor: AppColors.greyColor,
      body: isSearching
          ? Padding(
              padding: const EdgeInsets.all(22),
              child: FutureBuilder<List<Surah>>(
                future: QuranService().loadQuran(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Surahs found.'));
                  }

                  if (allSurahs.isEmpty) {
                    allSurahs = snapshot.data!;
                    filteredSurahs = allSurahs;
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredSurahs.length,
                          itemBuilder: (context, index) {
                            final surah = filteredSurahs[index];
                            return ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            surah.transliteration,
                                            textAlign: TextAlign.right,
                                            style: getTitleStyle(),
                                          ),
                                          Text(
                                            "verses ${surah.totalVerses}",
                                            textAlign: TextAlign.right,
                                            style: getbodyStyle(
                                                color: AppColors.color1),
                                          ),
                                          Text(
                                            surah.type,
                                            textAlign: TextAlign.right,
                                            style: getbodyStyle(
                                                color: AppColors.color1),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${surah.id}. ${surah.name}",
                                        textAlign: TextAlign.right,
                                        style: getTitleStyle(),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: AppColors.contanierCoror,
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SurahPageScreen(surah: surah),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(22),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Asalamu Alaikum !!!",
                      style: getbodyStyle(),
                    ),
                    Text(
                      user?.displayName ?? '',
                      style: getTitleStyle(fontSize: 25),
                    ),
                    Container(
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: AppColors.contanierCoror,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/Vector.png"),
                                  Gap(10),
                                  Text(
                                    "Last Read",
                                    style: getbodyStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.color1,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                lastSurahName != null && lastVerseId != null
                                    ? "$lastSurahName - Ayah $lastVerseId"
                                    : "No last read found",
                                style: getTitleStyle(),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.back, // لون الخلفية
                                  foregroundColor:
                                      AppColors.color1, // لون النص أو الأيقونة
                                  elevation: 5, // ارتفاع الظل
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // زاوية الانحناء
                                  ),
                                ),
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final id = prefs.getInt("last_surah_id");
                                  final name =
                                      prefs.getString("last_surah_name");
                                  final page = prefs.getInt('last_page_$id');

                                  if (id != null &&
                                      name != null &&
                                      page != null) {
                                    final surahList =
                                        await QuranService().loadQuran();
                                    final surah =
                                        surahList.firstWhere((s) => s.id == id);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            SurahPageScreen(surah: surah),
                                      ),
                                    );
                                  }
                                },
                                child: Text("استئناف القراءة"),
                              ),
                            ],
                          ),
                          Image.asset("assets/images/Vector2.png")
                        ],
                      ),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "Surah",
                          style: getTitleStyle(),
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 5.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.contanierCoror,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FutureBuilder<List<Surah>>(
                      future: QuranService().loadQuran(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No Surahs found.'));
                        }

                        var surahh = snapshot.data!;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: surahh.length,
                            itemBuilder: (context, index) {
                              final surah = surahh[index];
                              return ListTile(
                                title: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              surah.transliteration,
                                              textAlign: TextAlign.right,
                                              style: getTitleStyle(),
                                            ),
                                            Text(
                                              "verses ${surah.totalVerses}",
                                              textAlign: TextAlign.right,
                                              style: getbodyStyle(
                                                  color: AppColors.color1),
                                            ),
                                            Text(
                                              surah.type,
                                              textAlign: TextAlign.right,
                                              style: getbodyStyle(
                                                  color: AppColors.color1),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${surah.id}. ${surah.name}",
                                          textAlign: TextAlign.right,
                                          style: getTitleStyle(),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.contanierCoror,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VerseBar(surah: surah),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
