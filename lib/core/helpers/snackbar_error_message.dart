import '../widgets/custom_snackbar.dart';

showErrorMessage(String? message) {
  if (message == null) {
    return;
  }
  if (message == '404') {
    showCustomSnackBar(
        message: "Please_try_something_else",
        title: "No_valid_entry_found",
        isError: true);
  } else {
    showCustomSnackBar(
        message: 'Please_try_agein_later',
        title: "Unexpected_Error",
        isError: true);
  }
}

showNetworkError() {
  showCustomSnackBar(
      message: "Ckeck_your_Internet", title: "Network_Info", isError: true);
}
