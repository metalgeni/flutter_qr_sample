# flutter QR Code Detect

Material, Cupertino, DarkMode, QRCode Demo

## 간단 설명

### 사용한 SDK, Package 목록

    flutter SDK 3.7.6                 
    dart SDK 2.19.3

    cupertino_icons: 1.0.2
    flutter_platform_widgets: 3.0.0
    qr_code_scanner: 1.0.1
    provider: 6.0.5


### 폴더및 하위 모듈 목록및 설명


#### `lib/main.dart`
- main 모듈입니다. 
- Theme, ThemeMode, UI셋팅관련과 앱 초기화 부분입니다.
- 각 위젯은 flutter_platform_widgets를 이용하여 Material, Cupertino 작업을 하였습니다.
- 다크 모드나 iOS UI스타일, 폰트크기는 시스템설정에서 가져와 초기화 합니다.
- 시스템설정값은 MediaQuery를 이용하여 설정하며, 설정에서 `시스템설정 사용`을 Disable하면 커스텀 설정을 변경 할 수 있습니다.
###  `lib/define/define_global.dart`
- 공용 상수 모음입니다.

####  `lib/notifier/ui_change_notifier.dart`
- 상태관리 Provider Notifier입니다.  


####  `lib/page/page_home.dart`
- 메인메뉴 페이지입니다. 설정창열기, QR창열거, UIStyle변환버튼으로 구성되었습니다.

####  `lib/page/page_qrview.dart`
- QR 코드관련 페이지입니다.
- qr_code_scanner를 이용하였습니다. 
- 버튼의 LongPress 이벤트는 GestureDetector를 사용하였습니다. 
- onLongPressStart시 QR Camera를 Resume 하여 시작합니다. 
- onLongPressEnd시 QR Camera를 Pause 하여 중지합니다. 
- scanData는 QRView의 onQRViewCreated 콜백으로 detect된 정보를 화면에 출력합니다. 

####  `lib/page/page_setting.dart`
- 설정 페이지입니다. main모듈의 설정함수를 호출하여 UI설정을 변경합니다.



### 빌드방법
- 터미널에서 아래와 같이 순차적으로 실행합니다.
###
    flutter pub get
    flutter pub upgrade

- IDE ( `VSCode`나, `안드로이드 스튜디오` ) 에서 테스트 장비를 연결하여 실행버튼을 클릭합니다.
- 혹은 아래와 같이 실행하여 APK를 빌드합니다.
       
###
    flutter build apk --split-per-abi 

빌드방법의 자세한 내용은 다음 페이지를 참조 바랍니다.
- https://flutter-ko.dev/docs/deployment/android


