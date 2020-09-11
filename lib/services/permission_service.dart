import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxController{
  
  final PermissionHandler _permissionHandler = PermissionHandler();


  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  Future<bool> requestWriteExternalStoragePermission() async {
    var granted = await _requestPermission(PermissionGroup.storage);
    /*
    if (!granted) {
      onPermissionDenied();
    }
    */
    return granted;
  }

}