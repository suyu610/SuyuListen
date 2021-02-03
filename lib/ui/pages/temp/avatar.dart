import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/ui/components/avatar/custom_avatar/fluttermoji.dart';
import 'package:SuyuListening/ui/components/avatar/enums.dart';
import 'package:SuyuListening/ui/components/avatar/generator.dart';
import 'package:SuyuListening/ui/components/buttons/fancy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class TempPage extends StatefulWidget {
  TempPage({Key key}) : super(key: key);

  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  FluttermojiController fluttermojiController;
  @override
  void initState() {
    options = Options(
        accessories: Accessories.kurta,
        facialHair: FacialHair.moustachemagnum,
        facialHairColor: FacialHairColor.red);
    fluttermojiController = FluttermojiController();
    avatarSvg = randomAvatarSvgStr();
    super.initState();
  }

  String randomAvatarSvgStr() {
    // Options temp = ;
    // avatarSvg = ;
    setState(() {});
    return avatarSvg;
  }

  String avatarSvg;
  Options options;
  Future<Widget> draw() async {
    return FutureBuilder(
        future: fluttermojiController.getFluttermojiOptions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            );
          } else {
            return Text("");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                child: SvgPicture.string(avatarSvg)),
            SizedBox(
              height: 100,
            ),
            FancyButton(
                onPress: () async {
                  randomAvatarSvgStr();
                },
                label: "Login",
                gradient: kActiveButtonGradient),
            SelectableText(avatarSvg),
          ],
        ),
      ),
    );
  }
}
