import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchWordPage extends StatefulWidget {
  SearchWordPage({Key key}) : super(key: key);

  @override
  _SearchWordPageState createState() => _SearchWordPageState();
}

class _SearchWordPageState extends State<SearchWordPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FloatingSearchAppBarExample extends StatelessWidget {
  const FloatingSearchAppBarExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
      title: const Text('Title'),
      transitionDuration: const Duration(milliseconds: 800),
      color: Colors.greenAccent.shade100,
      colorOnScroll: Colors.greenAccent.shade200,
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class SomeScrollableContent extends StatelessWidget {
  const SomeScrollableContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBarScrollNotifier(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

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
