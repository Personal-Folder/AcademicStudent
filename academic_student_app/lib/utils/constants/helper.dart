import 'dart:io';
import 'package:academic_student/utils/constants/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File> fileFromUrl(String fileUrl) async {
  final response = await http.get(Uri.parse(storageApi + fileUrl));

  final documentDirectory = await getApplicationDocumentsDirectory();

  final String fileName = basename(
    fileUrl.split("/").last,
  );

  final file = File(join(documentDirectory.path, fileName));

  file.writeAsBytesSync(response.bodyBytes);

  return file;
}

Future downloadFile(String fileUrl) async {
  // storage permission ask
  try {
    final String fileName = basename(
      fileUrl.split("/").last,
    );
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final response = await http.get(Uri.parse(storageApi + fileUrl));

    Directory downloadDirectory;
    if (Platform.isAndroid) {
      downloadDirectory = Directory('/storage/emulated/0/Download');

      if (!await downloadDirectory.exists()) {
        downloadDirectory = (await getExternalStorageDirectory())!;
      }
      if (await File('${downloadDirectory.path}/$fileName').exists()) {
        return [true, '${downloadDirectory.path}/$fileName'];
      } else {
        FileDownloader.downloadFile(
          url: storageApi + fileUrl,
          onDownloadCompleted: (path) {
            final file = File('${downloadDirectory.path}/$fileName')
              ..writeAsBytesSync(
                response.bodyBytes,
              );
            return [true, file.path];
          },
          onProgress: (fileName, progress) {},
        );
      }
    } else {
      downloadDirectory = (await getDownloadsDirectory())!;
      final file = File(join(downloadDirectory.path, fileName));

      file.writeAsBytesSync(response.bodyBytes);
      return [true, file.path];
    }
  } catch (e) {
    return [false, e];
  }
}
