import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../utils/constants.dart';
import '../utils/helper.dart';
import '../utils/sharedprefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBarsVisible = false;
  final pageController = PageController(
    initialPage: sharedPrefs.lastPage,
  );

  final _pageNoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    final pageView = PageView(
      onPageChanged: (currentPage) {
        if (_isBarsVisible) {
          setState(() {
            sharedPrefs.lastPage = currentPage;
          });
        } else {
          sharedPrefs.lastPage = currentPage;
        }
        getToastMessage(currentPage: currentPage + 1);
      },
      controller: pageController,
      // reverse: true,
      allowImplicitScrolling: true,
      children: List.generate(
        604,
        (index) => Image.asset(
          'assets/images/${index + 1}.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            onTap: () => setState(() {
              _isBarsVisible = !_isBarsVisible;
            }),
            child: Stack(
              children: [
                pageView,
                Visibility(
                  visible: _isBarsVisible,
                  child: Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      color: Colors.black.withOpacity(0.75),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              getGoz2Name(sharedPrefs.lastPage + 1),
                              textAlign: TextAlign.right,
                              style: kTxtStyleWhite,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${sharedPrefs.lastPage + 1}',
                              textAlign: TextAlign.center,
                              style: kTxtStyleWhite,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'سورة ${getSuraName(sharedPrefs.lastPage + 1)}',
                              textAlign: TextAlign.left,
                              style: kTxtStyleWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isBarsVisible,
                  child: Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.75),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                icon: const Icon(
                                  CupertinoIcons.list_dash,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  print('fehres clicked');
                                },
                                label: Text(
                                  'الفهرس',
                                  style: kTxtStyleWhite,
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.grey.shade400),
                            Expanded(
                              child: TextButton.icon(
                                icon: const Icon(
                                  CupertinoIcons.paperplane_fill,
                                  color: Colors.white,
                                ),
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        title: const Center(
                                          child: Text(
                                            "الذهاب إلى صفحة",
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        content: _buildTextField(),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black87),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              if (_pageNoTextController.text
                                                  .trim()
                                                  .isEmpty) {
                                                return;
                                              }
                                              if (int.parse(
                                                          _pageNoTextController
                                                              .text
                                                              .trim()) <
                                                      1 ||
                                                  int.parse(
                                                          _pageNoTextController
                                                              .text
                                                              .trim()) >
                                                      604) {
                                                showToast(
                                                    'برجاء إدخال رقم صفحة صحيح');
                                                return;
                                              }

                                              pageController.jumpToPage(
                                                int.parse(_pageNoTextController
                                                        .text
                                                        .trim()) -
                                                    1,
                                              );
                                              _pageNoTextController.text = '';
                                              print(
                                                  'page is ${_pageNoTextController.text}');
                                            },
                                            child: const Text(
                                              'الذهاب',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                label: Text(
                                  'انتقال سريع',
                                  style: kTxtStyleWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField() {
    return TextField(
      controller: _pageNoTextController,
      cursorColor: Colors.black,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
      ),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'اكتب رقم الصفحة هنا',
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        isDense: true,
        hintStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
