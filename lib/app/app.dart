import 'package:google_docs/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:google_docs/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:google_docs/ui/views/login/login_view.dart';
import 'package:google_docs/services/google_service.dart';
import 'package:google_docs/ui/views/homescreen/homescreen_view.dart';
import 'package:google_docs/ui/views/documentscreen/documentscreen_view.dart';
import 'package:google_docs/services/document_service.dart';
import 'package:google_docs/services/socket_service.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomescreenView),
    MaterialRoute(page: DocumentscreenView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: GoogleService),
    LazySingleton(classType: DocumentService),
    LazySingleton(classType: SocketService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
