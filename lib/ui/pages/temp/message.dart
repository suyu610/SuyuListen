import 'package:SuyuListening/ui/pages/temp/foo.dart';
import 'package:flutter/material.dart';

class ParentWidget extends StatefulWidget {
  ParentWidget({Key key}) : super(key: key) {
    print("父组件 构造函数被调用");
  }

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  _ParentWidgetState() {
    print("_ParentWidgetState 构造函数被调用");
  }
  Foo1 foo1 = Foo1();
  Foo2 foo2;
  @override
  void initState() {
    foo2 = Foo2();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("父组件 调用子组件"),
        onPressed: () => {childKey.currentState.childFunc()},
      ),
    );
  }
}

class Foo1 {
  Foo1() {
    print("foo1 - 构造函数被调用");
  }
}

class Foo2 {
  Foo2() {
    print("foo2 - 构造函数被调用");
  }
}
