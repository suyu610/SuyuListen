//  SingleChildScrollView(
//         child: FutureBuilder(
//             future: getSimpleWordListByPrefix("ab", 20),
//             builder:
//                 (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 // 先从字符串转成json
//                 print(snapshot.data.runtimeType);
//                 var data =
//                     snapshot.data as List<SimpleWordEntity>;
//                 if (data.isNotEmpty) {
//                   return Container(
//                     alignment: Alignment.center,
//                     child: Text(data[0].word),
//                   );
//                 } else {
//                   return Container(
//                     alignment: Alignment.center,
//                     child: Text('empty'),
//                   );
//                 }
//               } else {
//                 return Container(
//                   alignment: Alignment.center,
//                   child: SpinKitFadingCircle(
//                     color: Colors.white,
//                     size: 30.0,
//                   ),
//                 );
//               }
//             }),
//       ),
