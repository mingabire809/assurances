import 'package:assurance/remot_config_service.dart';
import 'package:get_it/get_it.dart';
GetIt locat = GetIt.instance;
Future setupLocat() async{
  var remoteConfigService = await RemoteConfigService.getInstance();
  locat.registerSingleton(remoteConfigService);
}