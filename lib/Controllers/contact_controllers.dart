
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:savo/Constants/all_urls.dart';
import 'package:savo/Models/Models.dart';
import '../Helper/http_helper.dart';

class ContactController extends GetxController {
  List<Contact> allAvailableContacts = <Contact>[].obs;

  List connectedContactListing = [].obs;
  RxBool loadingContacts = false.obs;
  RxBool syncingContacts = false.obs;

  // function to update loading state
  void changeLoading(bool state) {
    loadingContacts.value = state;
    update();
  }

// function to fetch all contacts
  Future<void> fetchAllContacts() async {
    changeLoading(true);
    syncingContacts.value = true;

    List<Contact> available = await ContactsService.getContacts();
    allAvailableContacts.clear();
    for (var i = 0; i < available.length; i++) {
      allAvailableContacts.add(available[i]);
      changeLoading(false);
    }

    // if remove this then remove upper syncing variable alse
    syncContacts();
    //  // // // / // / / / / /

    update();
  }

// function to check read permissions for contacts
  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

// function to ask for cotact permissions
  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      fetchAllContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

// function to handle invalid permissions
  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(
        msg: 'Access to contact data denied',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      // Fluttertoast.showToast(
      //   msg: 'Contact data not available on device',
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.red,
      // );
    }
  }

// function to sync mobile contacts with api
  Future<void> syncContacts() async {
    connectedContactListing.clear();
    if (allAvailableContacts.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please wait we are fetching your contacts",
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
      );
    } else {
      syncingContacts.value = true;
      // list that has to be send to the API
      List contactsList = [];
      String contactsToSend = "";
      // using loop removing all the +91 or spaces
      for (var i = 0; i < allAvailableContacts.length; i++) {
        if (allAvailableContacts[i].phones!.isNotEmpty) {
          if (allAvailableContacts[i]
              .phones!
              .first
              .value
              .toString()
              .contains('+91')) {
            contactsList.add(
              allAvailableContacts[i]
                  .phones!
                  .first
                  .value
                  .toString()
                  .replaceAll('+91', '')
                  .replaceAll(' ', ''),
            );
          } else {
            contactsList.add(
              allAvailableContacts[i]
                  .phones!
                  .first
                  .value
                  .toString()
                  .replaceAll(' ', ''),
            );
          }
        }
      }
      contactsToSend =
          contactsList.toString().replaceAll(']', '').replaceAll('[', '').removeAllWhitespace;

      final NetworkHelper networkHelper = NetworkHelper(url: contactListUrl);
      var reply = await networkHelper.postData({
        'contect_list': contactsToSend,
      });

      if (reply['status'] == 1) {
        for (int i = 0; i < reply['data'].length; i++) {
          if (reply['data'][i].toString() != "null") {
            connectedContactListing.add(
              ContactModel(
                  fullName: reply['data'][i]['full_name'],
                  userId: reply['data'][i]['id'],
                  image: reply['data'][i]['profile_image'] ?? ''),
            );
          }
        }
      } else {
        print('Error in showing contact list');
      }
      syncingContacts.value = false;
    }
    update();
  }
}
