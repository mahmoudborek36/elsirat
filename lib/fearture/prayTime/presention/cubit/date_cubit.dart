import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elsirat/core/model/date_model.dart';
import 'package:elsirat/core/services/local.dart';
import 'package:elsirat/fearture/prayTime/data/repo/getdate_repo.dart';
import 'package:elsirat/fearture/prayTime/data/serices/getresponse/getresponse.dart';
import 'package:elsirat/fearture/prayTime/presention/cubit/date_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateAlitilState());
  Getresponse? getresponse;

  getdate(double? latitude, double? longitude, int month, int year,
      int index) async {
    emit(DateLoadingState());
    await GetdateRepo.getdate(latitude ?? 0, longitude ?? 0, month, year)
        .then((value) async {
      if (value != null) {
        await AppLocalStorege.cachTaskData(
            value.data![index].date!.gregorian?.date ?? '',
            DateModel(
                date: value.data![index].date!.gregorian?.date ?? '',
                fajr: value.data![index].timings?.fajr ?? '',
                sunrise: value.data![index].timings?.sunrise ?? '',
                dhuhr: value.data![index].timings?.dhuhr ?? '',
                asr: value.data![index].timings?.asr ?? '',
                maghrib: value.data![index].timings?.maghrib ?? '',
                isha: value.data![index].timings?.isha ?? '',
                isCompelete: false));
        emit(DatesuccessState());
      } else {
        emit(DaterrorState(erroe: "Something Went Wrong"));
      }
    });
  }
}
