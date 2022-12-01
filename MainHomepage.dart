import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:marquee/marquee.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'ColorContainer.dart';
import 'Controller.dart';
import 'Notification.dart';
import 'MapPage.dart';
import 'dart:async';
import 'Model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const List<String> _kOptions = <String>[

    '강남역','가능역',	'가양역',	'강남구청역',	'강동(강동성심병원)역',	'강동구청역',	'강변역',	'강일역',	'개롱역',	'개봉역',	'개화역',	'개화산역',	'거여역',	'경마공원역',	'경복궁역',	'경찰병원역',	'고덕(강동경희대병원)역',	'고려대(종암)역',	'고잔(고대안산병원)역',	'공릉(서울과학기술대)역',	'공항시장역',	'과천역',	'과천정부청사역',	'관악(안양예술공원)역',	'광나루(장신대)역',	'광명역',	'광명사거리역',	'광운대역',	'광화문(세종문화회관)역',	'광흥창(서강)역',	'구로역',	'구로디지털단지역',	'구반포역',	'구산역',	'구의역',	'구일역',	'구파발역',	'국회의사당(KDB산업은행)역',	'군포(지샘병원)역',	'굴포천역',	'굽은다리(강동구민회관앞)역',	'금천구청역',	'금호역',	'길동역',	'길음역',	'까치울역',	'낙성대역',	'남구로역',	'남부터미널역',	'남성역',	'남영역',	'남위례역',	'남태령역',	'남한산성입구(성남법원·검찰청)역',	'내방(유중아트센터)역',	'노들역',	'녹번역',	'녹사평(용산구청)역',	'녹양역',	'녹천역',	'논현역',	'단대오거리(신구대학교)역',	'답십리역',	'당고개역',	'당정(한세대)역',	'대곡역',	'대공원역',	'대방역',	'대야미역',	'대청역',	'대치역',	'대화역',	'대흥(서강대앞)역',	'덕계역',	'덕정역',	'도곡역',	'도림천역',	'도봉역',	'도원역',	'도화역',	'독립문역',	'독바위역',	'독산역',	'돌곶이역',	'동대입구역',	'동두천역',	'동두천중앙역',	'동묘앞역',	'동암역',	'동인천역',	'두정역',	'둔촌동역',	'둔촌오륜역',	'등촌역',	'디지털미디어시티역',	'뚝섬역',	'뚝섬유원지역',	'마곡역',	'마곡나루역',	'마두역',
    '마들역',	'마장역',	'마천역',	'마포역',	'마포구청역',	'망원역',	'망월사역',	'매봉역',	'먹골역',	'면목(서일대입구)역',	'명동역',	'명일역',	'명학(성결대학교)역',	'모란역',	'목동역',	'몽촌토성(평화의문)역',	'무악재역',	'문래역',	'문정역',	'미사역',	'미아(서울사이버대학)역',	'미아사거리역',	'반월역',	'반포역',	'발산역',	'방배역',	'배방역',	'백석역',	'백운역',	'버티고개역',	'범계역',	'별내별가람역',	'병점역',	'보라매역',	'보문역',	'보산역',	'복정역',	'봉명역',	'봉은사역',	'봉천역',	'봉화산(서울의료원)역',	'부개역',	'부천역',	'부천시청역',	'부천종합운동장역',	'부평역',	'부평구청역',	'사가정(녹색병원)역',	'사평역',	'산곡역',	'산본역',	'산성역',	'삼산체육관역',	'삼성역',	'삼성중앙역',	'삼송역',	'삼전역',	'상계역',	'상도역',	'상동역',	'상록수(안산대학교)역',	'상봉역',	'상수역',	'상왕십리역',	'상월곡(한국과학기술역구원)역',	'상일동역',	'새절(신사)역',	'샛강역',	'서대문(강북삼성병원)역',	'서동탄역',	'서울대입구역',	'서정리역',	'서초역',	'석남(거북시장)역',	'석수역',	'석촌고분역',	'선릉역',	'선바위역',	'선유도역',	'선정릉역',	'성균관대역',	'성수역',	'성신여대입구역',	'성환역',	'세류역',	'세마역',	'소사역',	'소요산역',	'송내역',	'송정역',	'송탄역',	'송파역',	'송파나루역',	'수락산역',	'수리산역',	'수서역',	'수원역',	'수유(강북구청)역',	'수진역',	'숙대입구역',	'숭실대입구(살피재)역',
    '신금호역',	'신길온천역',	'신내역',	'신논현역',	'신답역',	'신대방역',	'신대방삼거리역',	'신림역',	'신목동역',	'신반포역',	'신방화역',	'신사역',	'신용산역',	'신이문역',	'신정(은행정)역',	'신정네거리역',	'신중동역',	'신창역',	'신촌역',	'신풍역',	'신흥역',	'쌍문역',	'쌍용역',	'아산역',	'아차산(어린이대공원후문)역',	'아현역',	'안국역',	'안산역',	'안암(고대병원앞)역',	'안양역',	'암사역',	'압구정역',	'애오개역',	'양재역',	'양주역',	'양천구청역',	'양천향교역',	'양평역',	'어린이대공원(세종대)역',	'언주(강남차병원)역',	'여의나루역',	'역곡역',	'역삼역',	'역촌역',	'염창역',	'영등포역',	'오남역',	'오류동역',	'오목교(목동운동장앞)역',	'오산역',	'오산대역',	'오이도역',	'옥수역',	'온양온천역',	'외대앞역',	'용답역',	'용두역',	'용마산(용마폭포공원)역',	'용산역',	'우장산역',	'원당역',	'원흥역',	'월계역',	'월곡(동덕여대)역',	'월드컵경기장(성산)역',	'을지로입구역',	'응암역',	'의왕(한국교통대학교)역',	'의정부역',	'이대역',	'이촌(국립중앙박물관)역',	'이태원역',	'인덕원역',	'인천역',	'일원역',	'잠실나루역',	'잠실새내역',	'잠원역',	'장승배기역',	'장암역',	'장지역',	'장한평역',	'정발산역',	'정왕역',	'제기동역',	'제물포역',	'종각역',	'종로5가역',	'주안역',	'주엽역',	'중계(한국성서대)역',	'중곡역',	'중동역',	'중앙역(서울예술대학교)',	'중앙보훈병원역',	'중화역',	'증미역',	'증산(명지대앞)역',	'지축역',	'지행역',	'직산역',
    '진위역',	'진접역',	'창신역',	'천안역',	'천왕역',	'철산역',	'청담(제일정형외과병원)역',	'청량리역',	'초지(안산공과대학)역',	'춘의역',	'탕정역',	'평촌(한림대성심병원)역',	'평택역',	'평택지제역',	'하계(을지대 을지병원)역',	'하남검단산역',	'하남시청(덕풍.신장)역',	'하남풍산역',	'학동(나누리병원)역',	'학여울역',	'한강진역',	'한대앞역',	'한성대입구역',	'한성백제역',	'한양대역',	'행당역',	'혜화(서울대학교병원)역',	'홍대입구역',	'홍제역',	'화곡역',	'화랑대(서울대입구)역',	'화서역',	'화정역',	'회기역',	'회룡역',	'회현역',	'효창공원앞역',	'흑석(중앙대입구)역',	'간석역',	'시청역',	'신도림역',	'신설동역',	'교대역',	'을지로3가역',	'종로3가역',	'금정역',	'동대문역',	'동대문역사문화공원역',	'사당역',	'서울역',	'창동역',	'충무로역',	'까치산역',	'방학역',	'신길역',	'영등포구청역',	'오금역',	'왕십리역',	'을지로4가역',	'충정로(경기대입구)역',	'공덕역',	'불광역',	'삼각지역',	'석계역',	'신당역',	'약수역',	'연신내역',	'청구역',	'합정(홀트아동복지회)역',	'가산디지털단지역',	'건대입구역',	'고속터미널역',	'군자(능동)역',	'노원역',	'대림(구로구청)역',	'도봉산역',	'온수역',	'이수(총신대입구)역',	'태릉입구역',	'가락시장역',	'잠실역',	'천호(풍납토성)역',	'김포공항역',	'노량진역',	'당산역',	'동작(현충원)역',	'방이역',	'석촌(한솔병원)역',	'여의도역',	'올림픽공원(한국체대)역',	'종합운동장역',

  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double lat = 0.0, lng = 0.0, lat1 = 0.0, lng1 = 0.0;
  double lat11 = 0.0, lng11 = 0.0; /// 11는 출퇴근시 목적지 데이터 저장때 사용

  double  lat2 = 0.0, lng2 = 0.0;
  double latS = 0.0, lngS = 0.0, latSS = 0.0, lngSS = 0.0; /// ss는 출퇴근시 환승역 데이터 저장때 사용

  double streamlat =0.0, streamlng =0.0;

  late String description ='';
  late String stringNumber ='Line2';
  late String stringNumber11 ='';
  late String stringNumberB ='Line2';
  late String stringNumberC ='Line2';

  late String stringNumber2 ='Line2';
  late String stringNumberS ='';
  late String stringNumberSS ='';

  late String subwayName1 = 'TRIP TO SEOUL';
  late String subwayName11 = 'TRIP TO SEOUL';
  late String subwayName2 = '';
  late String subwayNameS = '';
  late String subwayNameSS = '';

  late String engName1 = '';
  late String engName11 = '';

  late String passenger1 = 'Enter Your Name ';
  late String passenger2 = '';

  late int countvalue = subwayName1.length;
  late int countvalueN = stringNumber.length;

  late int lineNumber = 0;
  late int lineNumber2 = 0;

  late SharedPreferences preferences;
  String QRdata = '1234ffov3pp5oq23lk';

  void getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 25,
  );

  void findMyposition(
      List<SubwayModel> subway, double lat, double lng, String subwayName1)
  {
    final index = subway.indexWhere((element) => element.name == subwayName1);

    lat1 = subway[index].lat;
    lng1 = subway[index].lng;
    stringNumber = subway[index].Stringline;
    stringNumberB = subway[index].Stringline2;
    stringNumberC = subway[index].Stringline3;
    engName1 = subway[index].engname;

  }

  late StreamSubscription? _getPositionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best))
        .listen((Position? position) {
      print(position == null ? 'Unknown'
          : '****${position.latitude.toString()}, ****${position.longitude.toString()}');
      position == null ? 'Unknown' : streamlat = position.latitude;
      position == null ? 'Unknown' : streamlng = position.longitude;
    });

  Future init() async {
    preferences = await SharedPreferences.getInstance();

    String? passenger2 = preferences.getString('passenger2');
    if (passenger2 == null) return;
    setState(() => this.passenger2 = passenger2);

    String? subwayNameS = preferences.getString('Transfer Station');
    if (subwayNameS == null) return;
    setState(() => this.subwayNameS = subwayNameS);

    String? stringNumberS = preferences.getString('String Number');
    if (subwayNameS == null) return;
    setState(() => this.stringNumberS = stringNumberS!);

    double? latS = preferences.getDouble('lat');
    if (latS == null) return;
    setState(() => this.latS = latS);

    double? lngS = preferences.getDouble('lng');
    if (subwayNameS == null) return;
    setState(() => this.lngS = lngS!);
  }

  @override
  void initState() {
    init();
    getLocation();
    // _getPositionSubscription;
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final controllerA = Get.put(BuilderController());
    final controller11 = Get.put(BuilderController11());
    final controllerSS = Get.put(BuilderControllerSS());


    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;
    double mainBoxWidth = appWidth * 0.915;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: appHeight * 0.17,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: mainBoxWidth/40,),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                          onTap: (){
                          },
                          child: QrImage(data: QRdata)),
                    ),

                    SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                        : mainBoxHeight/15,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mainBoxHeight/25,
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat('y-M-dd EEE').format(DateTime.now()),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: appRatio >= 0.5? mainBoxHeight/22
                                      : mainBoxHeight/25,
                                  color: Colors.black),
                            ),
                            SizedBox(width: mainBoxHeight/50,),
                            SizedBox(
                              height: appHeight * 0.58 * 0.025,
                              width: appWidth * 0.025,
                              child:
                                Container(
                                    color: stringNumberS == 'Line1'? const Color(0xff2b3990)
                                        : stringNumberS == 'Line2'? const Color(0xff009D3E)
                                        : stringNumberS == 'Line3'? const Color(0xffEF7C1C)
                                        : stringNumberS == 'Line4'? const Color(0xff00A5DE)
                                        : stringNumberS == 'Line5'? const Color(0xff996CAC)
                                        : stringNumberS == 'Line6'? const Color(0xffCD7C2F)
                                        : stringNumberS == 'Line7'? const Color(0xff747F00)
                                        : stringNumberS == 'Line8'? const Color(0xffEA545D)
                                        : stringNumberS == 'Line9'? const Color(0xffBB8336)
                                        : stringNumberS == '서해'? const Color(0xff8FC31F)
                                        : stringNumberS == '공항'? const Color(0xff0090D2)
                                        : stringNumberS == '경의중앙'? const Color(0xff77C4A3)
                                        : stringNumberS == '경춘'? const Color(0xff0C8E72)
                                        : stringNumberS == '수인분당'? const Color(0xff8FC31F)
                                        : stringNumberS == '신분당'? const Color(0xffD4003B)
                                        : stringNumberS == '경강선'? const Color(0xff003DA5)
                                        : stringNumberS == '인천1선'? const Color(0xff7CA8D5)
                                        : stringNumberS == '인천2선'? const Color(0xffED8B00)
                                        : stringNumberS == '에버라인'? const Color(0xff6FB245)
                                        : stringNumberS == '의정부'? const Color(0xffFDA600)
                                        : stringNumberS == '우이신설'? const Color(0xffB7C452)
                                        : stringNumberS == '김포골드'? const Color(0xffA17800)
                                        : stringNumberS == '신림'? const Color(0xff6789CA)
                                        :  Colors.white
                                ),

                            ),
                          ],
                        ),
                        SizedBox(
                          height: mainBoxHeight/50,
                        ),
                        Container(
                          height:  mainBoxHeight/7,
                          width: mainBoxWidth/2.2,
                          child: GestureDetector(
                            child: BarcodeWidget(
                              data: 'FR9XZ227A93V6',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: mainBoxHeight/35),
                              barcode: Barcode.code93(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.white,
                height: appHeight * 0.60,
                width: appWidth * 0.915,
                child: Column(
                  children: <Widget>[
                    const DottedLine(
                        dashLength: 15, dashGapLength: 6, lineThickness: 7),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              SizedBox(
                                height: appHeight * 0.58 * 0.90,
                                width: appWidth * 0.08,
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                      color: stringNumber == 'Line1'? const Color(0xff2b3990)
                                          : stringNumber == 'Line2'? const Color(0xff009D3E)
                                          : stringNumber == 'Line3'? const Color(0xffEF7C1C)
                                          : stringNumber == 'Line4'? const Color(0xff00A5DE)
                                          : stringNumber == 'Line5'? const Color(0xff996CAC)
                                          : stringNumber == 'Line6'? const Color(0xffCD7C2F)
                                          : stringNumber == 'Line7'? const Color(0xff747F00)
                                          : stringNumber == 'Line8'? const Color(0xffEA545D)
                                          : stringNumber == 'Line9'? const Color(0xffBB8336)
                                          : stringNumber == '서해'? const Color(0xff8FC31F)
                                          : stringNumber == '공항'? const Color(0xff0090D2)
                                          : stringNumber == '경의중앙'? const Color(0xff77C4A3)
                                          : stringNumber == '경춘'? const Color(0xff0C8E72)
                                          : stringNumber == '수인분당'? const Color(0xff8FC31F)
                                          : stringNumber == '신분당'? const Color(0xffD4003B)
                                          : stringNumber == '경강선'? const Color(0xff003DA5)
                                          : stringNumber == '인천1선'? const Color(0xff7CA8D5)
                                          : stringNumber == '인천2선'? const Color(0xffED8B00)
                                          : stringNumber == '에버라인'? const Color(0xff6FB245)
                                          : stringNumber == '의정부'? const Color(0xffFDA600)
                                          : stringNumber == '우이신설'? const Color(0xffB7C452)
                                          : stringNumber == '김포골드'? const Color(0xffA17800)
                                          : stringNumber == '신림'? const Color(0xff6789CA)
                                          :  Colors.green
                                  ),
                              ),

                              ),
                            ],
                          ),
                          SizedBox(width: mainBoxHeight/50,),
                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                height: appWidth * 0.13,
                                width: mainBoxHeight/5.5,
                                color: Colors.black,
                                alignment: Alignment.center,
                                child: 
                                DropdownButton<dynamic>(
                                    value: stringNumber,
                                    dropdownColor: Colors.black,
                                    underline: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black,
                                    ),
                                    icon: SizedBox.shrink(),
                                    style: const TextStyle(color: Colors.white,),
                                    onChanged: (dynamic? newValue) {
                                      setState(() {
                                        stringNumber = newValue!;
                                        print(stringNumber);
                                      });
                                    },
                                    items: <dynamic>[
                                      'Line1', 'Line2', 'Line3', 'Line4','Line5','Line6','Line7','Line8','Line9','신분당','수인분당','경의중앙']
                                        .map<DropdownMenuItem<dynamic>>((dynamic value) {
                                      return DropdownMenuItem<dynamic>(
                                        value: value,
                                        child: Text(value,style: TextStyle(
                                            fontSize: mainBoxHeight/25,
                                            fontWeight: FontWeight.bold,color: Colors.white),),
                                      );
                                    }).toList()
                                ),
                              ),

                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                height: appHeight * 0.58 * 0.75,
                                decoration: BoxDecoration(
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${subwayName1}',maxLines: 1, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              /// IPHONE 11 기준 mainBoxHeight == 520
                                          subwayName1.length == 3? mainBoxHeight/8 /// 80
                                              : subwayName1.length == 4 ? mainBoxHeight/8.5 /// 80
                                              : subwayName1.length == 5 ? mainBoxHeight/8.5 /// 80
                                              : subwayName1.length == 6 ? mainBoxHeight/8.6 /// 60
                                              : subwayName1.length == 7 ? mainBoxHeight/8.6 /// 60
                                              : subwayName1.length == 8 ? mainBoxHeight/11.4 /// 45
                                              : subwayName1.length == 9 ? mainBoxHeight/11.4 /// 45
                                              : mainBoxHeight/14.4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      ),
                                      Text('    ${engName1}', style: TextStyle(
                                          fontSize: mainBoxHeight/35),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                              : mainBoxHeight/15,),
                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/20,),

                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Container(
                                        color: Colors.white,
                                        height: 400,
                                        child: Form(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                      ),
                                                      width: 80,
                                                      height: 80,
                                                      child: QrImage(
                                                        data: QRdata,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('Boarding Psss',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                        Text(
                                                          DateFormat('y-M-dd EEE \nHH:mm:ss').format(DateTime.now()),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Autocomplete<String>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) {
                                                        if (textEditingValue.text == '') {
                                                          return const Iterable<
                                                              String>.empty();
                                                        }
                                                        subwayName1 = textEditingValue.text;
                                                        return MyHomePage._kOptions.where(
                                                                (String option) => option.contains(textEditingValue.text.toLowerCase()));
                                                      },
                                                      onSelected: (String selection) {
                                                        debugPrint('You just selected $selection');
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onEdittingComplete) {

                                                        return TextField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onEditingComplete: onEdittingComplete,
                                                          decoration: InputDecoration(
                                                            hintText: '입력 후 완료버튼을 누르세요',
                                                            labelText: 'Enter Destination',hintStyle: TextStyle(color: Colors.black), /// 'Enter Destination'
                                                            border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                            ),
                                                            prefixIcon: const Icon(
                                                              Icons.subway,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          onSubmitted: (val) {
                                                            setState(() {
                                                              subwayName1 = val;
                                                              Fluttertoast.showToast(
                                                                  msg: '${subwayName1}이 입력되었습니다.',
                                                                  gravity: ToastGravity.CENTER);
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Autocomplete<String>(
                                                      optionsBuilder: (TextEditingValue
                                                      textEditingValue) {
                                                        if (textEditingValue.text == '') {
                                                          return const Iterable<
                                                              String>.empty();
                                                        } else {
                                                          subwayName2 = textEditingValue.text;
                                                          return MyHomePage._kOptions.where(
                                                                  (String option) => option.contains(textEditingValue.text.toLowerCase()));
                                                        }
                                                      },
                                                      onSelected: (String selection) {
                                                        debugPrint('You just selected $selection');
                                                      },
                                                      fieldViewBuilder: (context,
                                                          controller,
                                                          focusNode,
                                                          onEdittingComplete) {

                                                        return TextField(
                                                          controller: controller,
                                                          focusNode: focusNode,
                                                          onEditingComplete:
                                                          onEdittingComplete,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            prefixIcon: const Icon(Icons.u_turn_left_sharp, color: Colors.black,),
                                                            labelText: 'Transfer Station',hintStyle: TextStyle(color: Colors.black), /// Transfer Station
                                                            hintText: '입력 후 완료버튼을 누르세요',
                                                          ),

                                                          onSubmitted: (val) {
                                                            setState(() {
                                                             if(val.contains('역')){
                                                               subwayName2 = val;
                                                               controllerA.findMyposition2(SubwayInfo2,subwayName2);
                                                               preferences.setString('Transfer Station',subwayName2);
                                                               preferences.setString('String Number',controllerA.stringNumber2);
                                                               preferences.setDouble('lat',controllerA.lat2);
                                                               preferences.setDouble('lng',controllerA.lng2);
                                                             }else if(val.isEmpty){
                                                               subwayName2 = val;
                                                             }else{
                                                               return null;
                                                             }

                                                            });
                                                          },

                                                        );
                                                      },
                                                    ),

                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    InputHistoryTextField(
                                                        historyKey: "3",
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          prefixIcon: const Icon(
                                                            Icons.person,
                                                            color: Colors.black,
                                                          ),
                                                          labelText: 'Enter your name',hintStyle: TextStyle(color: Colors.black), /// Enter your name
                                                          hintText: '입력 후 완료버튼을 누르세요',
                                                        ),
                                                        onSubmitted: (val2) async {
                                                          setState(() {
                                                            passenger1 = val2;
                                                            print(
                                                                'passenger2 ${passenger1}');
                                                            preferences.setString('passenger2',passenger1);
                                                          });
                                                        }),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white),
                                                      child:
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 60,
                                                            width: 15,
                                                            child: Container(
                                                              decoration:   BoxDecoration(
                                                                  color: stringNumber == 'Line1'? Color(0xff2b3990)
                                                                      : stringNumber == 'Line2'? const Color(0xff00B140)
                                                                      : stringNumber == 'Line3'? const Color(0xffFC4C02)
                                                                      : stringNumber == 'Line4'? const Color(0xff00A5DE)
                                                                      : stringNumber == 'Line5'? const Color(0xff996CAC)
                                                                      : stringNumber == 'Line6'? const Color(0xffC75D28)
                                                                      : stringNumber == 'Line7'? const Color(0xff747F00)
                                                                      : stringNumber == 'Line8'? const Color(0xffEA545D)
                                                                      : stringNumber == 'Line9'? const Color(0xffBB8336)
                                                                      : stringNumber == '서해'? const Color(0xff8FC31F)
                                                                      : stringNumber == '공항'? const Color(0xff0090D2)
                                                                      : stringNumber == '경의중앙'? const Color(0xff77C4A3)
                                                                      : stringNumber == '경춘'? const Color(0xff0C8E72)
                                                                      : stringNumber == '수인분당'? const Color(0xff8FC31F)
                                                                      : stringNumber == '신분당'? const Color(0xffD4003B)
                                                                      : stringNumber == '경강'? const Color(0xff003DA5)
                                                                      : stringNumber == '인천1선'? const Color(0xff7CA8D5)
                                                                      : stringNumber == '인천2선'? const Color(0xffED8B00)
                                                                      : stringNumber == '에버라인'? const Color(0xff6FB245)
                                                                      : stringNumber == '의정부'? const Color(0xffFDA600)
                                                                      : stringNumber == '우이신설'? const Color(0xffB7C452)
                                                                      : stringNumber == '김포골드'? const Color(0xffA17800)
                                                                      : stringNumber == '신림'? const Color(0xff6789CA)
                                                                      : Colors.green
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),

                                                          Container(
                                                            height: 70,
                                                            width: 50,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height: 10,),
                                                                Text('Date',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                                                SizedBox(height: 10,),
                                                                Text(DateFormat('M-dd').format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height: 10,),
                                                                Text('Transfer',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                                                SizedBox(height: 10,),
                                                                Text('${subwayNameS}' != null? '${subwayNameS}' : 'Input Location',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis),
                                                              ],),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Container(
                                                            height: 70,
                                                            width: 90,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(height: 10,),
                                                                Text('Passenger',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                                                SizedBox(height: 10,),
                                                                Text('${passenger2}' != null ? '${passenger2}' : 'Input name',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),overflow: TextOverflow.ellipsis)
                                                              ],),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        SizedBox(
                                          child: TextButton(
                                              onPressed: () {
                                                _getPositionSubscription?.pause();
                                                print('Stop NOtification');
                                                Fluttertoast.showToast(
                                                    msg: '위치 추적을 중단합니다.',
                                                    gravity: ToastGravity.CENTER);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                        ),
                                        SizedBox(
                                          child: TextButton(
                                              onPressed: () {

                                                Fluttertoast.showToast(
                                                    msg: '목적지 정보가 입력되었습니다.\n위치 추적을 시작합니다.',
                                                    gravity: ToastGravity.CENTER);
                                                String? passenger2 = preferences.getString('passenger2');
                                                if (passenger2 == null) return;
                                                setState(() => this.passenger2 = passenger2);

                                                String? subwayNameS = preferences.getString('Transfer Station');
                                                if (subwayNameS == null) return;
                                                setState(() => this.subwayNameS = subwayNameS);

                                                String? stringNumberS = preferences.getString('String Number');
                                                if (stringNumberS == null) return;
                                                setState(() => this.stringNumberS = stringNumberS);

                                                double? latS = preferences.getDouble('lat');
                                                if (stringNumberS == null) return;
                                                setState(() => this.latS = latS!);

                                                double? lngS = preferences.getDouble('lng');
                                                if (stringNumberS == null) return;
                                                setState(() => this.lngS = lngS!);

                                                setState(() {
                                                  findMyposition(SubwayInfo2,lat1,lng1,subwayName1);

                                                  Navigator.pop(context);

                                                });
                                                if (streamlat.toStringAsFixed(2) == lat1.toStringAsFixed(2)
                                                    && streamlng.toStringAsFixed(2) == lng1.toStringAsFixed(2)) {
                                                  print('call NOtification');
                                                  Noti.showBigTextNotification(
                                                      title: " 목적지 ${subwayName1}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 목적지인 ${subwayName1}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin);
                                                  Noti.showBigTextNotification(
                                                      title: " 목적지 ${subwayName1}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 목적지인 ${subwayName1}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin);
                                                  Noti.showBigTextNotification(
                                                      title: " 목적지 ${subwayName1}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 목적지인 ${subwayName1}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin)
                                                      .then((_) => _getPositionSubscription?.pause());

                                                } else if (streamlat.toStringAsFixed(2) == latS?.toStringAsFixed(2)
                                                    && streamlng.toStringAsFixed(2) == lngS?.toStringAsFixed(2)) {
                                                  print('call Transfer Station NOtification');
                                                  Noti.showBigTextNotification(
                                                      title: " 환승역 ${subwayName2}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 환승역인 ${subwayName2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin);
                                                  Noti.showBigTextNotification(
                                                      title: " 환승역 ${subwayName2}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 환승역인 ${subwayName2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin);
                                                  Noti.showBigTextNotification(
                                                      title: " 환승역 ${subwayNameS}에 곧 도착합니다.",
                                                      body: "\n ${passenger2}님의 환승역인 ${subwayNameS}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                                                      fln: flutterLocalNotificationsPlugin)
                                                      .then((_) => _getPositionSubscription?.pause());

                                                }
                                                else {
                                                  print('Still wait for doing Notification');
                                                  return _getPositionSubscription?.resume();
                                                }
                                                // Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Adapt',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                /// ------------------------
                                onDoubleTap: (){

                                },
                                child: SizedBox(
                                      width: appHeight/6,
                                child: Icon(Icons.subway,
                                  size: mainBoxHeight/7,),
                                ),
                              ),


                              SizedBox(height: mainBoxHeight/20,),

                              Container(
                                child: Center(
                                  child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('NUMBER', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('23X13P', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        SizedBox(width: mainBoxHeight/20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('GATE', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('0010', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/9,),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('DATE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('SEAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('CLASS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/60,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat('M/dd ').format(DateTime.now()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: mainBoxHeight/25),
                                        ),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('1XX',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('FIRST C',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/10,
                                    ),
                                    Text(
                                      'PASSENGER :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/25),
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/40,
                                    ),
                                    Text(
                                      '${passenger2}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/30),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onLongPress: (){
                            Fluttertoast.showToast(
                                msg: '모든 환승역 정보를 초기화합니다.',
                                gravity: ToastGravity.CENTER);
                            setState(() {
                              preferences.clear(); /// 모든 저장값 삭제
                            });

                          },
                          onTap: (){
                            Get.to(MapPage(),arguments: [subwayName1,lat1,lng1,lineNumber,stringNumber,stringNumberS,subwayNameS,latS,lngS]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: appWidth * 0.15,
                            height: appWidth * 0.08,
                              color: stringNumber == 'Line1'? Color(0xff2b3990)
                                  : stringNumber == 'Line2'? const Color(0xff00B140)
                                  : stringNumber == 'Line3'? const Color(0xffFC4C02)
                                  : stringNumber == 'Line4'? const Color(0xff00A5DE)
                                  : stringNumber == 'Line5'? const Color(0xff996CAC)
                                  : stringNumber == 'Line6'? const Color(0xffC75D28)
                                  : stringNumber == 'Line7'? const Color(0xff747F00)
                                  : stringNumber == 'Line8'? const Color(0xffEA545D)
                                  : stringNumber == 'Line9'? const Color(0xffBB8336)
                                  : stringNumber == '서해'? const Color(0xff8FC31F)
                                  : stringNumber == '공항'? const Color(0xff0090D2)
                                  : stringNumber == '경의중앙'? const Color(0xff77C4A3)
                                  : stringNumber == '경춘'? const Color(0xff0C8E72)
                                  : stringNumber == '수인분당'? const Color(0xff8FC31F)
                                  : stringNumber == '신분당'? const Color(0xffD4003B)
                                  : stringNumber == '경강'? const Color(0xff003DA5)
                                  : stringNumber == '인천1선'? const Color(0xff7CA8D5)
                                  : stringNumber == '인천2선'? const Color(0xffED8B00)
                                  : stringNumber == '에버라인'? const Color(0xff6FB245)
                                  : stringNumber == '의정부'? const Color(0xffFDA600)
                                  : stringNumber == '우이신설'? const Color(0xffB7C452)
                                  : stringNumber == '김포골드'? const Color(0xffA17800)
                                  : stringNumber == '신림'? const Color(0xff6789CA)
                                  : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    height: appHeight * 0.30,
                    // width: appWidth * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // SizedBox(width: mainBoxWidth/30,),
                        Container(height: appHeight/10.5 ,width: appHeight/17.9,color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.all(appRatio >= 0.5? 10.0
                              : 5.0),
                          child: BarcodeWidget(
                            data: '-------LAFAYETTE.co--------',style: TextStyle(fontWeight: FontWeight.bold),
                            barcode: Barcode.code128(),
                          ),
                        ),
                       GestureDetector(
                           onTap: () {
                             Fluttertoast.showToast(
                                 msg: '${passenger2}님 출근합니다......',
                                 gravity: ToastGravity.CENTER);
                           },
                           onDoubleTap: (){
                             Fluttertoast.showToast(
                                 msg: '${passenger2}님 퇴근합니다......',
                                 gravity: ToastGravity.CENTER);

                           },
                           child: Container(height: 85,width: 50,color: Colors.white,)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}