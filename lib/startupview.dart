import 'package:assurance/basemodel.dart';
import 'package:assurance/locat.dart';
import 'package:assurance/remot_config_service.dart';

class StartUpViewModel extends BaseModel{
  final RemoteConfigService _remoteConfigService = locat<RemoteConfigService>();


  Future handleStartupLogic() async{
    await _remoteConfigService.initialise();
  }

}