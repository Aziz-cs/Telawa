import 'package:flutter/material.dart';
import 'package:telawa/pages/quran_page.dart';
import 'package:telawa/utils/helper.dart';

import '../utils/sharedprefs.dart';

class JuzItem extends StatelessWidget {
  const JuzItem({
    Key? key,
    required this.juzAndIndexMap,
  }) : super(key: key);

  final Map<int, int> juzAndIndexMap;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        tileColor: Colors.blueGrey.shade700,
        leading: const Icon(
          Icons.bookmark,
          color: Colors.white70,
        ),
        title: Text(
          'الجزء ${juzAndIndexMap.keys.first}',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_right_outlined,
          color: Colors.white70,
        ),
        onTap: () {
          sharedPrefs.lastPage = juzAndIndexMap.values.first - 1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuranPage(),
            ),
          );
          showToast('جزء ${juzAndIndexMap.keys.first}');
        },
      ),
    );
  }
}
