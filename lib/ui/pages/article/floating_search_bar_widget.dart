import 'package:SuyuListening/config/global.dart';
import 'package:SuyuListening/route/router_helper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:styled_text/styled_text.dart';

import '../../../constant/theme_color.dart';
import '../../../entity/entities.dart';

Widget buildFloatingSearchBar(
    context,
    bool isSearchBarFocus,
    void searchBarFocusChange(bool focus),
    searchUpdate(String prefix),
    List<SimpleWordEntity> searchWordList) {
  return FloatingSearchBar(
    key: Global.floatingSearchBarKey,
    elevation: 0,
    
    padding: EdgeInsets.only(left: 8.w, right: 8.w),
    margins: EdgeInsets.only(
        top: 10.h, right: 10.w, left: isSearchBarFocus ? 10.w : 800.w),
    onFocusChanged: (v) => {searchBarFocusChange(v)},
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 300),
    implicitDuration: const Duration(milliseconds: 300),
    debounceDelay: const Duration(milliseconds: 300),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: 0,
    hint: "在这查单词", //
    hintStyle: TextStyle(
      color: Colors.black.withAlpha(100),
    ),
    borderRadius: BorderRadius.circular(8),
    openAxisAlignment: 0.0,
    backgroundColor: colorWhite,
    maxWidth: 750.w,
    
    onQueryChanged: (query) {
      searchUpdate(query);
    },

    textInputType: TextInputType.name,

    transition: SlideFadeFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                // 避免called on null
                children: (searchWordList?.map((list) {
                      return Container(
                        height: 112.h,
                        child: GestureDetector(
                          onTap: () => {
                            RouterHelper.router.navigateTo(
                                context, "/word_detail",
                                transition: TransitionType.fadeIn)
                          },
                          child: ListTile(
                            title: Text(list.word),
                            subtitle: Text(
                              list.translation,
                            ),
                            trailing: GestureDetector(
                                onTap: () =>
                                    {EasyLoading.showSuccess("已加入生词本")},
                                child: Icon(
                                  Ionicons.add,
                                  color: Colors.black,
                                  size: 30.sp,
                                )),
                          ),
                        ),
                      );
                    })?.toList() ??
                    [
                      Container(
                          color: silver,
                          height: 112.h,
                          child: Center(
                            child: StyledText(
                              text: '<fail/> 未搜索到  ',
                              styles: {
                                'fail': IconStyle(Ionicons.skull_outline),
                              },
                            ),
                          ))
                    ]))),
      );
    },
  );
}
