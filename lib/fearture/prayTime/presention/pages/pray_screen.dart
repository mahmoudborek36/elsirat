import 'package:elsirat/core/model/date_model.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/fearture/prayTime/data/repo/getdate_repo.dart';
import 'package:elsirat/fearture/prayTime/presention/widgets/qibla_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DateModel> allDates = [];
  final PageController _pageController = PageController();
  int currentPageIndex = 0;
  bool hasScrolledToToday = false;

  @override
  void initState() {
    super.initState();
    getLocationAndFetchPrayerTimes();
  }

  Future<void> getdate(
      double? latitude, double? longitude, int month, int year) async {
    final value =
        await GetdateRepo.getdate(latitude ?? 0, longitude ?? 0, month, year);
    if (value != null && value.data != null) {
      await AppLocalStorege.dateBox?.clear();

      for (var day in value.data!) {
        final dateKey = day.date?.gregorian?.date ?? '';
        final dateModel = DateModel(
          date: dateKey,
          fajr: day.timings?.fajr ?? '',
          sunrise: day.timings?.sunrise ?? '',
          dhuhr: day.timings?.dhuhr ?? '',
          asr: day.timings?.asr ?? '',
          maghrib: day.timings?.maghrib ?? '',
          isha: day.timings?.isha ?? '',
          isCompelete: false,
        );
        await AppLocalStorege.cachTaskData(dateKey, dateModel);
      }
    }
  }

  Future<void> getLocationAndFetchPrayerTimes() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition();
      double? latitudee = position.latitude;
      double? longitude3 = position.longitude;

      final now = DateTime.now();
      await getdate(latitudee, longitude3, now.month, now.year);
    } catch (e) {
      print('Location error: $e');
    }
  }

  void scrollToToday() {
    final box = AppLocalStorege.dateBox!;
    allDates = box.values.toList();

    final todayStr = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final todayIndex =
        allDates.indexWhere((element) => element.date == todayStr);

    if (todayIndex != -1 && !hasScrolledToToday) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(todayIndex);
          setState(() {
            currentPageIndex = todayIndex;
            hasScrolledToToday = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        surfaceTintColor: AppColors.back,
        title: Text(
          'Prayer Times',
          style: getHeadlineTextStyle(),
        ),
        backgroundColor: AppColors.back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QiblaScreen()),
                  );
                },
                icon: Icon(Icons.explore),
                label: Text("اتجاه القبلة"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: AppLocalStorege.dateBox!.listenable(),
                builder: (context, Box, child) {
                  List<DateModel> date = Box.values.toList();
                  allDates = date; // save for scrollToToday()
                  if (!hasScrolledToToday &&
                      date.isNotEmpty &&
                      _pageController.hasClients) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final todayStr =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                      final todayIndex = date
                          .indexWhere((element) => element.date == todayStr);

                      if (todayIndex != -1) {
                        _pageController.jumpToPage(todayIndex);
                        setState(() {
                          hasScrolledToToday = true;
                        });
                      }
                    });
                  }
                  return Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: date.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final day = date[index];
                          final todayStr =
                              DateFormat('dd-MM-yyyy').format(DateTime.now());

                          return ListTile(
                            title: Column(
                              children: [
                                Text(
                                  "${day.date} 🗓",
                                  style: getbodyStyle(
                                    color: day.date == todayStr
                                        ? AppColors.black
                                        : AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(20),
                                Container(
                                  padding: EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                      color: AppColors.color1,
                                      borderRadius:
                                          BorderRadius.circular(22.r)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Fajr: ${day.fajr}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                      Text("Sunrise: ${day.sunrise}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                      Text("Dhuhr: ${day.dhuhr}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                      Text("Asr: ${day.asr}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                      Text("Maghrib: ${day.maghrib}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                      Text("Isha: ${day.isha}",
                                          style: getbodyStyle(
                                              color: AppColors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // Left Arrow
                      if (currentPageIndex > 0)
                        Positioned(
                          left: 0,
                          top: MediaQuery.of(context).size.height * 0.2,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: AppColors.color1),
                            onPressed: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      // Right Arrow
                      if (currentPageIndex < date.length - 1)
                        Positioned(
                          right: 0,
                          top: MediaQuery.of(context).size.height * 0.2,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: AppColors.color1),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
