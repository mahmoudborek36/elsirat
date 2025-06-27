// ✅ هذا الكود يعمل حفظ واستئناف تلقائي للآية الأخيرة التي توقف عندها المستخدم
// باستخدام SharedPreferences

import 'package:elsirat/core/services%20copy/local.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/screens/suraList/widgets/arroe_back_widgeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/surah.dart';

class SurahPageScreen extends StatefulWidget {
  final Surah surah;

  const SurahPageScreen({super.key, required this.surah});

  @override
  State<SurahPageScreen> createState() => _SurahPageScreenState();
}

class _SurahPageScreenState extends State<SurahPageScreen> {
  late PageController _pageController;
  int _lastSavedPage = 0;
  static const int versesPerPage = 5;

  @override
  void initState() {
    super.initState();
    _loadLastSavedPage();
  }

  Future<void> _loadLastSavedPage() async {
    final savedPage =
        AppLocalStorageshared.getCachedData('last_page_${widget.surah.id}') ??
            0;
    setState(() {
      _lastSavedPage = savedPage;
      _pageController = PageController(initialPage: _lastSavedPage);
    });
  }

  Future<void> _savePage(int page) async {
    // احسب أول آية في الصفحة
    int verseIndex = page * versesPerPage;
    final verse = widget.surah.verses[verseIndex];

    await AppLocalStorageshared.cacheData('last_page_${widget.surah.id}', page);
    await AppLocalStorageshared.cacheData('last_surah_id', widget.surah.id);
    await AppLocalStorageshared.cacheData(
        'last_surah_name', widget.surah.transliteration);
    await AppLocalStorageshared.cacheData('last_verse_id', verse.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.surah.verses.length / versesPerPage).ceil();

    if (_pageController == null) {
      _pageController = PageController(initialPage: _lastSavedPage);
    }

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: arroeBackWidgeta(),
        title: const Text(
          "Quran",
          style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.color1),
        ),
        centerTitle: false,
        backgroundColor: AppColors.greyColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.surah.transliteration,
                  style: getHeadlineTextStyle(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "verses ${widget.surah.totalVerses.toString()}",
                          style: getTitleStyle(),
                        ),
                        Text(
                          widget.surah.type,
                          style: getTitleStyle(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/VectorShare.svg"),
                        const SizedBox(width: 30),
                        SvgPicture.asset("assets/icons/VectorPlay.svg"),
                        const SizedBox(width: 30),
                        SvgPicture.asset("assets/icons/VectorbookMark.svg"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: (page) {
                _savePage(page);
              },
              reverse: true,
              itemBuilder: (context, pageIndex) {
                int startIndex = pageIndex * versesPerPage;
                int endIndex = (startIndex + versesPerPage);
                if (endIndex > widget.surah.verses.length) {
                  endIndex = widget.surah.verses.length;
                }
                List<Verse> versesPage =
                    widget.surah.verses.sublist(startIndex, endIndex);

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: versesPage.length,
                  itemBuilder: (context, index) {
                    var verse = versesPage[index];
                    return ListTile(
                      title: Text(
                        " ${verse.text} (${verse.id}) ",
                        textAlign: TextAlign.end,
                        style: getTitleStyle(hight: 4),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: AppColors.color1, // غيّر اللون هنا
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.white,
        ),
        tooltip: 'Go to first page',
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endTop, // يخلي الزر على الشمال
    );
  }
}
