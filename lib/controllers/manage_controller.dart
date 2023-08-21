import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class ManageController extends GetxController {
  RxBool isDownloading = false.obs;
  String extension = "";

  Future downloadAndOpenFile({String? url, String? fileName}) async {
    try {
      final file = await downloadFile(url, fileName);
      if (file == null) return null;
      log('Path :: ${file.path}');
      await OpenFile.open(
        file.path,
      );
    } catch (e) {
      kerrorSnackbar(message: "Somthing went wrong");
    }
  }

  Future<File?> downloadFile(String? url, String? fileName) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File("${appStorage.path}/$fileName");
      final response = await Dio().get(
        url!,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
