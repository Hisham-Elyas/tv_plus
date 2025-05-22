import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  Future<void> dialNumber(String number) async {
    final Uri phoneUri = Uri.parse("tel:$number");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not dial $number';
    }
  }

  Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Hello FAISAL Tv', 'body': ''},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $email';
    }
  }

  Future<void> openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }
}
