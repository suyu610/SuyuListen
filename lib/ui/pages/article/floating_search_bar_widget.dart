import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

Widget buildFloatingSearchBar(
    FloatingSearchBarController floatingSearchBarController,
    bool isSearchBarFocus,
    void searchBarFocusChange(bool focus),
    searchUpdate(String prefix),
    List<SimpleWordEntity> searchWordList) {
  return FloatingSearchBar(
    controller: floatingSearchBarController,
    elevation: 2,
    padding: isSearchBarFocus
        ? EdgeInsets.only(left: 8.w, right: 8.w)
        : EdgeInsets.only(right: 0.w, left: 4.w),
    margins: EdgeInsets.only(
        top: isSearchBarFocus ? 10.h : 1043.5.h,
        right: isSearchBarFocus ? 10.w : 0,
        left: isSearchBarFocus ? 10.w : 660.w),
    onFocusChanged: (v) => {searchBarFocusChange(v)},

    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 300),
    implicitDuration: const Duration(milliseconds: 300),
    debounceDelay: const Duration(milliseconds: 300),

    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: 0,
    hint: "", //

    borderRadius: isSearchBarFocus
        ? BorderRadius.circular(8)
        : BorderRadius.only(
            topLeft: Radius.circular(45.h),
          ),
    openAxisAlignment: 0.0,
    backgroundColor: colorWhite,
    maxWidth: isSearchBarFocus ? 600 : 90.w,

    onQueryChanged: (query) {
      searchUpdate(query);
    },

    textInputType: TextInputType.name,

    transition: CircularFloatingSearchBarTransition(),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          size: 10.sp,
          icon: const Icon(Icons.search),
          onPressed: () {
            floatingSearchBarController.open();
          },
        ),
      ),
      // FloatingSearchBarAction.searchToClear(
      //   showIfClosed: false,
      // ),
    ],
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: searchWordList.map((list) {
              return Container(
                height: 112.h,
                child: ListTile(
                  title: Text(list.word),
                  subtitle: Text(
                    list.translation,
                  ),
                  // trailing: Text('${list.detail.toString()}'),
                ),
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
