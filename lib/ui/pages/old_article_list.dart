// import 'dart:async';

// import 'package:SuyuListening/constant/theme_color.dart';
// import 'package:SuyuListening/provider/theme_provider.dart';
// import 'package:SuyuListening/sample_data/data.dart';
// import 'package:SuyuListening/ui/components/Menu/menu_widget.dart';
// import 'package:SuyuListening/ui/components/app_retain_widget.dart';
// import 'package:SuyuListening/ui/pages/article/article_detail.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:fab_circular_menu/fab_circular_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_inner_drawer/inner_drawer.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:provider/provider.dart';
// import 'package:ionicons/ionicons.dart' as icon_2;

// class Model {
//   String id = UniqueKey().toString();
//   int index;

//   @override
//   String toString() {
//     return index.toString();
//   }
// }

// class OldArticleListPage extends StatefulWidget {
//   OldArticleListPage({Key key}) : super(key: key);

//   @override
//   _OldArticleListPageState createState() => _OldArticleListPageState();
// }

// class _OldArticleListPageState extends State<OldArticleListPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
//   var columnValue = 0;
//   ScrollController _scrollController;
//   Future<void> _handleRefresh() {
//     final Completer<void> completer = Completer<void>();
//     Timer(const Duration(milliseconds: 300), () {
//       completer.complete();
//     });

//     return completer.future.then<void>((_) {
//       EasyLoading.showSuccess("刷新成功");
//     });
//   }

//   SwipeActionController controller;

//   List<Model> list = List.generate(30, (index) {
//     return Model()..index = index;
//   });

//   @override
//   void initState() {
//     _scrollController = new ScrollController();
//     _scrollController.addListener(() {
//       if (fabKey.currentState.isOpen) {
//         fabKey.currentState.close();
//       }
//     });
//     controller = SwipeActionController(selectedIndexPathsChangeCallback:
//         (changedIndexPaths, selected, currentCount) {
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildInnerDraw(
//         context, _scrollController, _refreshIndicatorKey, _handleRefresh);
//   }

//   Widget _getIconButton(color, icon) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: color,
//       ),
//       child: Icon(
//         icon,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _item(int index) {
//     return SwipeActionCell(
//         controller: controller,
//         index: index,
//         key: ValueKey(list[index]),
//         trailingActions: [
//           SwipeAction(
//             onTap: (handler) async {
//               // print(list);
//               list.removeAt(index);
//               setState(() {});
//               // print(list);
//             },
//             nestedAction: SwipeNestedAction(
//               content: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.red,
//                 ),
//                 width: 130.w,
//                 height: 60.h,
//                 child: OverflowBox(
//                   maxWidth: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                         size: 34.sp,
//                       ),
//                       Text('确认删除',
//                           style:
//                               TextStyle(color: Colors.white, fontSize: 24.sp)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             color: Colors.transparent,
//             content: _getIconButton(Colors.red, Icons.delete),
//           ),
//           SwipeAction(
//             onTap: (handler) async {
//               list.removeAt(index);
//               setState(() {});
//             },
//             color: Colors.transparent,
//             content: _getIconButton(ThemeColors.colorTheme, Icons.star),
//           ),
//         ],
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//           child: GestureDetector(
//             // behavior: HitTestBehavior.deferToChild,
//             onHorizontalDragUpdate: (detail) => {
//               if (detail.delta.dx > 0)
//                 {
//                   fabKey.currentState.close(),
//                   // print(detail.delta.dx),
//                   Provider.of<ThemeProvider>(context, listen: false)
//                       .innerDrawerKey
//                       .currentState
//                       .toggle(direction: InnerDrawerDirection.start),
//                 }
//               else
//                 {}
//             },
//             onLongPress: () => {
//               CoolAlert.show(
//                   backgroundColor: ThemeColors.colorTheme,
//                   context: context,
//                   confirmBtnColor: ThemeColors.colorTheme,
//                   confirmBtnTextStyle: TextStyle(color: Colors.black),
//                   type: CoolAlertType.confirm,
//                   lottieAsset: "assets/lotties/lf30_editor_obrqtkg5.json",
//                   title: "确认删除${list[index]}吗?",
//                   confirmBtnText: "确认",
//                   cancelBtnText: "取消",
//                   cancelBtnTextStyle: TextStyle(color: Colors.black),
//                   onConfirmBtnTap: () async {
//                     list.removeAt(index);
//                     setState(() {});
//                     Navigator.pop(context);
//                     EasyLoading.showSuccess("删除成功");
//                   })
//             },
//             child: Card(
//               shape: const RoundedRectangleBorder(
//                 //形状
//                 //修改圆角
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//               ),
//               child: GestureDetector(
//                 onTap: () => {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return ArticleDetailPage();
//                   }))
//                 },
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListTile(
//                           leading: Container(
//                               height: 80.h,
//                               width: 80.h,
//                               decoration: BoxDecoration(
//                                   // image: Image
//                                   boxShadow: [
//                                     BoxShadow(
//                                       offset: Offset(1, 1),
//                                       color:
//                                           ThemeColors.colorTheme.withAlpha(40),
//                                       blurRadius: 0.5,
//                                       spreadRadius: 1.0,
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       new BorderRadius.all(Radius.circular(10)),
//                                   border: new Border.all(width: 1),
//                                   color: Colors.white),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Icon(
//                                     Icons.face,
//                                     color: Colors.black,
//                                   ),
//                                   Text(
//                                     "详情",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 20.sp),
//                                   ),
//                                 ],
//                               )),
//                           title: Text(
//                               "${list[index].index + 1}. " +
//                                   "${list[index]}" * 12,
//                               maxLines: 2),
//                           subtitle: Text(columnList[(index.toInt() % 4)]),
//                           trailing: Icon(
//                             Icons.cloud_download_outlined,
//                             color: Colors.black,
//                           )),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 10.h),
//                       child: SizedBox(
//                         width: 630.w,
//                         child: LinearProgressIndicator(
//                           value: index.toDouble(),
//                           backgroundColor: Colors.black.withAlpha(30), // 背景色为黑色
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                               ThemeColors.colorTheme),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget _buildInnerDraw(
//       BuildContext context,
//       ScrollController _scrollController,
//       _refreshIndicatorKey,
//       _handleRefresh) {
//     return InnerDrawer(
//       key: Provider.of<ThemeProvider>(context).innerDrawerKey,
//       leftChild: _buildLeftChild(context),
//       scaffold:
//           _buildRightChild(context, _scrollController, _refreshIndicatorKey),
//       // 一些配置
//       onTapClose: true,
//       swipe: true,
//       colorTransitionChild: Colors.grey[900],
//       colorTransitionScaffold: Colors.white70,
//       offset: IDOffset.only(bottom: 0, right: 0, left: 0.3),
//       proportionalChildArea: true,
//       borderRadius: 0,
//       leftAnimationType: InnerDrawerAnimation.quadratic,
//       backgroundDecoration: BoxDecoration(color: Colors.grey[900]),
//       innerDrawerCallback: (a) => {},
//     );
//   }

//   Widget _buildLeftChild(BuildContext context) {
//     return GestureDetector(
//         onHorizontalDragEnd: (detail) {
//           Provider.of<ThemeProvider>(context, listen: false)
//               .innerDrawerKey
//               .currentState
//               .toggle(direction: InnerDrawerDirection.start);
//         },
//         child: MenuWidget());
//   }

//   Widget _buildRightChild(BuildContext context,
//       ScrollController _scrollController, GlobalKey _refreshIndicatorKey) {
//     return AppRetainWidget(
//       child: Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         floatingActionButton: FabCircularMenu(
//             key: fabKey,
//             ringDiameter: 500.w,
//             ringWidth: 150.w,
//             ringColor: ThemeColors.colorTheme,
//             fabOpenColor: Colors.black,
//             fabOpenIcon: Icon(
//               Icons.menu,
//               size: 30.sp,
//             ),
//             fabCloseIcon: Icon(
//               Icons.close,
//               color: Colors.white,
//             ),
//             // fabElevation: 5,
//             // animationDuration: Duration(microseconds: 1000),
//             fabColor: ThemeColors.colorTheme,
//             fabSize: 80.sp,
//             children: <Widget>[
//               IconButton(
//                   icon: Icon(Ionicons.md_switch),
//                   onPressed: () {
//                     print('Home');
//                   }),
//               IconButton(
//                   icon: Icon(icon_2.Ionicons.person_sharp),
//                   onPressed: () {
//                     print('Home');
//                   }),
//               IconButton(
//                   icon: Icon(icon_2.Ionicons.book_sharp),
//                   onPressed: () {
//                     print('Home');
//                   }),
//               IconButton(
//                   icon: Icon(icon_2.Ionicons.people_sharp),
//                   onPressed: () {
//                     print('Favorite');
//                   })
//             ]),
//         key: _scaffoldKey,
//         appBar: AppBar(
//           brightness: Brightness.light, // status bar brightness
//           leading: GestureDetector(
//             onTap: () => {
//               fabKey.currentState.close(),
//               Provider.of<ThemeProvider>(context, listen: false)
//                   .innerDrawerKey
//                   .currentState
//                   .toggle(direction: InnerDrawerDirection.start)
//             },
//             child: Icon(
//               Ionicons.md_menu,
//               color: Colors.black,
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   onChanged: (T) {
//                     //下拉菜单item点击之后的回调
//                     setState(() {
//                       columnValue = T;
//                     });
//                   },
//                   value: columnValue,
//                   focusColor: Colors.transparent,
//                   items: columnList.map((item) {
//                     return DropdownMenuItem(
//                         value: columnList.indexOf(item),
//                         child: Text(
//                           item.toString(),
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           textAlign: TextAlign.center,
//                         ));
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//           backgroundColor: ThemeColors.colorTheme,
//           elevation: 0,
//           title: Text(
//             "文章列表",
//             style: TextStyle(color: Colors.black, fontSize: 34.sp),
//           ),
//         ),
//         body: Column(
//           children: [
//             // 已读的区域
//             Container(
//               decoration: BoxDecoration(
//                   // gradient: LinearGradient(
//                   //     colors: [gradientStartColor, gradientEndColor],
//                   //     begin: Alignment.topCenter,
//                   //     end: Alignment.bottomCenter,
//                   //     stops: [0.3, 0.7]),
//                   // color: Colors.grey.shade100,
//                   // border:
//                   //     new Border.all(width: 1, color: Colors.black.withAlpha(40)),
//                   ),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   // autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 3),
//                   disableCenter: true,
//                   viewportFraction: 0.8,
//                   height: 180.h,
//                 ),
//                 items: list
//                     .map((item) => Container(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(10),
//                           height: 180.h,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 offset: Offset(1, 1),
//                                 color: Colors.black.withAlpha(10),
//                                 blurRadius: 5,
//                                 spreadRadius: 1.0,
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(20.w),
//                             border: new Border.all(width: 1),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 (item.toString()) * 30,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 "垃圾，我完成了哦",
//                                 style: TextStyle(fontSize: 28.sp),
//                               ),
//                               Text("2021-01-26 19:31",
//                                   style: TextStyle(fontSize: 28.sp)),
//                             ],
//                           ),
//                         ))
//                     .toList(),
//               ),
//               width: 375 * 2.w,
//             ),
//             LiquidPullToRefresh(
//               backgroundColor: ThemeColors.colorWhite,
//               // color: ThemeColors.colorWhite,
//               height: 100.h,
//               springAnimationDurationInMilliseconds: 500,
//               onRefresh: _handleRefresh,
//               key: _refreshIndicatorKey,
//               showChildOpacityTransition: true,
//               child: Container(
//                 height: 1000.h,
//                 child: ListView.builder(
//                   itemCount: list.length,
//                   physics: BouncingScrollPhysics(),
//                   controller: _scrollController,

//                   //范围内进行包裹（内容多高ListView就多高）
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     return _item(index);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
