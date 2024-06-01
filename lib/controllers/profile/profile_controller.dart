import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quizz_app/controllers/controllers.dart';
import 'package:quizz_app/firebase/references.dart';
import 'package:quizz_app/models/models.dart' show QuizPaperModel, RecentTest;
import 'package:quizz_app/services/firebase/firebasestorage_service.dart';
import 'package:quizz_app/utils/logger.dart';

class ProfileController extends GetxController {
  @override
  void onReady() {
    getMyRecentTests();
    super.onReady();
  }

  final allRecentTest = <RecentTest>[].obs;
  final isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getMyRecentTests() async {
    try {
      User? user = Get.find<AuthController>().getUser();
      if (user == null) return;
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> data =
          await recentQuizes(userId: user.email!).get();
      final tests =
          data.docs.map((paper) => RecentTest.fromSnapshot(paper)).toList();

      for (RecentTest test in tests) {
        DocumentSnapshot<Map<String, dynamic>> quizPaperSnaphot =
            await quizePaperFR.doc(test.paperId).get();
        final quizPaper = QuizPaperModel.fromSnapshot(quizPaperSnaphot);

        final url =
            await Get.find<FireBaseStorageService>().getImage(quizPaper.title);
        test.papername = quizPaper.title;
        test.paperimage = url;
      }

      allRecentTest.assignAll(tests);
    } catch (e) {
      AppLogger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserProfile(String name, String? photoURL) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Update Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        if (photoURL != null) 'profilepic': photoURL,
      });

      // Update Firebase Auth
      await user.updateDisplayName(name);
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
      await user.reload();
    }
  }
}
