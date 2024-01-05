import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<PermissionStatus> permissionStatus({
    required Permission permission,
  }) async {
    PermissionStatus status = await permission.status;

    return status;
  }

  static Future<bool> hasPermission({required Permission permission}) async {
    PermissionStatus status = await permissionStatus(permission: permission);

    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  static Future<bool> askPermissions({
    required Permission permission,
    required BuildContext context,
    bool askAgainIfDenied = true,
  }) async {
    bool status = await hasPermission(permission: permission);

    if (!status) {
      final request = await permission.request();
      status = request.isGranted;
    }

    return status;
  }
}
