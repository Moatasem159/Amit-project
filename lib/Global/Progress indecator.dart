import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Dialogs {
  static ProgressDialog _progressDialog;

  static Future showProgressDialog({BuildContext context, String msg}) async {
    if (_progressDialog != null) _progressDialog = null;

    _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );

    _progressDialog.style(
      message: msg,
      padding: EdgeInsets.all(10),
      borderRadius: 10,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(strokeWidth: 3,),
      elevation: 5,
      insetAnimCurve: Curves.easeInOut,
      progress: 0,
      maxProgress: 100,
      progressTextStyle: TextStyle(color: Colors.black,fontSize: 5,fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
    );

    await _progressDialog.show();
  }


  static Future updateProgressDialog({String msg}) async {
    _progressDialog.update(
      progress: 50.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );



  }

  static Future hideProgressDialog()async{
    if(_progressDialog!=null&&_progressDialog.isShowing())
      await _progressDialog.hide();
  }
}
