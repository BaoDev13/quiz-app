import 'package:get/get.dart';
import 'package:quizz_app/firebase/firebase_configs.dart';
import 'package:quizz_app/utils/utils.dart';

class FireBaseStorageService extends GetxService {
  Future<String?> getImage(String? imageName) async {
    if (imageName == null) return null;

    try {
      var urlref =
          firebaseStorage.child('quiz_paper_images').child('$imageName.png');
      var url = await urlref.getDownloadURL();
      return url;
    } on Exception catch (e) {
      AppLogger.e(e);
      return null;
    }
  }
}
