import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/auth_controller.dart';
import 'package:quizz_app/firebase/references.dart';
import 'package:quizz_app/models/models.dart' show QuizPaperModel;
import 'package:quizz_app/screens/screens.dart' show QuizeScreen;
import 'package:quizz_app/services/firebase/firebasestorage_service.dart';
import 'package:quizz_app/utils/logger.dart';

class QuizPaperController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;
  var isLoading = false.obs;

  Future<void> getAllPapers() async {
    try {
      isLoading(true);
      QuerySnapshot<Map<String, dynamic>> data = await quizePaperFR.get();
      final paperList =
          data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imageUrl =
            await Get.find<FireBaseStorageService>().getImage(paper.title);
        paper.imageUrl = imageUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    } finally {
      isLoading(false);
    }
  }

  void navigatoQuestions(
      {required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(QuizeScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
