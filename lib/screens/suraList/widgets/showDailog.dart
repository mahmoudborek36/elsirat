import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elsirat/core/utils/colors.dart';
import 'package:elsirat/core/utils/text_style.dart';
import 'package:elsirat/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

showDailogMethod(
    BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? userData,
    String datauser,
    Future<void> Function() updateData,
    TextEditingController con) {
  showDialog(
    context: context,
    builder: (context) {
      var con = TextEditingController(
          text: userData?[datauser] == '' || userData?[datauser] == null
              ? 'لم تضاف'
              : userData?[datauser]);
      var form = GlobalKey<FormState>();
      return SimpleDialog(
        alignment: Alignment.center,
        contentPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        children: [
          Form(
            key: form,
            child: Column(
              children: [
                Text(
                  'ادخل ',
                  style: getbodyStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: con,
                  decoration: const InputDecoration(
                      filled: true, fillColor: AppColors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'حفظ التعديل',
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      updateData();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
