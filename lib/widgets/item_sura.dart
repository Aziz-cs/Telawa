import 'package:flutter/material.dart';
import 'package:telawa/pages/quran_page.dart';
import 'package:telawa/utils/helper.dart';

import '../model/sura.dart';
import '../utils/sharedprefs.dart';

class SuraItem extends StatelessWidget {
  const SuraItem({
    Key? key,
    required this.sura,
  }) : super(key: key);

  final Sura sura;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        tileColor: Colors.blueGrey.shade700,
        leading: Padding(
          padding: const EdgeInsets.only(right: 13),
          child: Text(
            sura.order.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        title: Text(
          sura.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          getSuraDetails(sura),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        trailing: Column(
          children: [
            const Text(
              'صفحة',
              style: TextStyle(
                color: Colors.white, fontSize: 12,
                // fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              sura.pageNo.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.1,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        onTap: () {
          sharedPrefs.lastPage = sura.pageNo - 1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuranPage(),
            ),
          );
        },
      ),
    );
  }
}

getSuraDetails(Sura sura) {
  String suraType = sura.isMakka ? 'مكية' : 'مدينة';
  String suraVerseNumbers = sura.verseNumbers.toString() + ' ' + 'آية';
  return suraType + ' - ' + suraVerseNumbers;
}
