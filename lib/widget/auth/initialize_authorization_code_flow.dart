import 'package:flutter/material.dart';
import 'package:flutter_auth/singletons/auth_parameter.dart';

/// 認可コードフローを開始する Widget.
class InitializeAuthorizationCodeFlowWidget extends StatelessWidget{
  const InitializeAuthorizationCodeFlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authorizationEndpointUri = AuthParameter().buildAuthorizationEndpointUri();

    // TODO: implement build
    throw UnimplementedError();
  }

}
