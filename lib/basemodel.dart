import 'package:assurance/remot_config_service.dart';
import 'package:flutter/material.dart';

import 'locat.dart';

class BaseModel extends ChangeNotifier{
  final RemoteConfigService _remoteConfigService = locat<RemoteConfigService>();
  bool get showMainBanner => _remoteConfigService.showMainBanner;

  bool _busy = false;
  bool get busy=> _busy;

  void setBusy(bool value){
    _busy = value;
    notifyListeners();
  }
}