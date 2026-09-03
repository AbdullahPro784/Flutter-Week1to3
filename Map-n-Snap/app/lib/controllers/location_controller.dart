import "dart:async";
import "dart:convert";
import "dart:typed_data";
import "package:firebase_auth/firebase_auth.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:app/models/location.dart";
import "package:app/services/firestore_service.dart";
import "package:app/utils/helpers.dart";

class LocationController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  final ImagePicker imagePicker = ImagePicker();

  var locationsList = <Location>[].obs;
  var isLoadingDatabase = true.obs;
  StreamSubscription? databaseListener;

  var selectedImages = <XFile>[].obs;
  var selectedLatitude = Rxn<double>();
  var selectedLongitude = Rxn<double>();
  var selectedDate = DateTime.now().obs;
  var isSavingForm = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      listenToDatabase();
    }
  }

  void listenToDatabase() {
    isLoadingDatabase.value = true;
    databaseListener?.cancel();

    databaseListener = firestoreService.getLocations().listen((
      List<Location> newList,
    ) {
      locationsList.assignAll(newList);
      isLoadingDatabase.value = false;
    });
  }

  void startListening() {
    if (databaseListener == null) listenToDatabase();
  }

  Future<void> pickImages() async {
    List<XFile> pickedFiles = await imagePicker.pickMultiImage();
    if (pickedFiles.isNotEmpty) selectedImages.addAll(pickedFiles);
  }

  void removeImage(int index) => selectedImages.removeAt(index);
  void setPickedLocation(double lat, double lng) {
    selectedLatitude.value = lat;
    selectedLongitude.value = lng;
  }

  void setDate(DateTime date) => selectedDate.value = date;

  Future<bool> saveLocation(String title, String notes) async {
    if (selectedLatitude.value == null || selectedLongitude.value == null) {
      Get.snackbar("Missing location", "Please tap map to pick spot");
      return false;
    }
    if (title.trim().isEmpty) {
      Get.snackbar("Missing title", "Please write a title");
      return false;
    }

    isSavingForm.value = true;

    try {
      List<String> base64Images = [];
      for (XFile imageFile in selectedImages) {
        Uint8List imageBytes = await imageFile.readAsBytes();
        base64Images.add(base64Encode(imageBytes));
      }

      String autoPlaceName = await Helpers.getPlaceName(
        selectedLatitude.value!,
        selectedLongitude.value!,
      );

      await firestoreService.addLocation(
        title: title.trim(),
        notes: notes.trim(),
        lat: selectedLatitude.value!,
        lng: selectedLongitude.value!,
        date: selectedDate.value,
        photoUrls: base64Images,
        placeName: autoPlaceName,
      );

      selectedImages.clear();
      selectedLatitude.value = null;
      selectedLongitude.value = null;
      selectedDate.value = DateTime.now();

      isSavingForm.value = false;
      return true;
    } catch (error) {
      isSavingForm.value = false;
      Get.snackbar("Error", " Unable to continue: $error");
      return false;
    }
  }

  Future<void> deleteLocation(String locationId) async {
    await firestoreService.deleteLocation(locationId);
  }

  @override
  void onClose() {
    databaseListener?.cancel();
    super.onClose();
  }
}
