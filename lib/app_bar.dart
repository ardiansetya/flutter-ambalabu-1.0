import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Dashboard', style: TextStyle(fontFamily: 'NightinTokyo')),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String result) async {
            if (result == 'WhatsApp Web Call') {
              await _launchWhatsApp(context, '628818653880', isCall: true);
            } else if (result == 'WhatsApp Web Message') {
              await _launchWhatsApp(context, '628818653880', message: 'Hello, I need assistance!');
            } else if (result == 'Maps') {
              await _launchMaps(context);
            } else if (result == 'Update User') {
              Navigator.pushNamed(context, '/update-user');
            } else if (result == 'Logout') {
              _logout(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'WhatsApp Web Call',
              child: Text('WhatsApp Web Call'),
            ),
            const PopupMenuItem<String>(
              value: 'WhatsApp Web Message',
              child: Text('WhatsApp Web Message'),
            ),
            const PopupMenuItem<String>(
              value: 'Maps',
              child: Text('Maps'),
            ),
            const PopupMenuItem<String>(
              value: 'Update User',
              child: Text('Update Profile'),
            ),
            const PopupMenuItem<String>(
              value: 'Logout',
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchWhatsApp(BuildContext context, String phone, {String message = '', bool isCall = false}) async {
    try {
      phone = phone.replaceAll(RegExp(r'[^\d]'), '');
      String url;

      if (Platform.isAndroid) {
        if (isCall) {
          url = "whatsapp://send?phone=$phone&text=Halo";
        } else {
          url = "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}";
        }
      } else {
        // Fallback untuk platform lain
        url = "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
      }

      final Uri whatsappUri = Uri.parse(url);
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorDialog(context, 'WhatsApp tidak terinstall');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }

  Future<void> _launchMaps(BuildContext context) async {
    try {
      final String googleMapsUrl;

      if (Platform.isAndroid) {
        googleMapsUrl = 'google.navigation:q=restaurants+near+me';
        final Uri mapsUri = Uri.parse(googleMapsUrl);

        if (await canLaunchUrl(mapsUri)) {
          await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
        } else {
          // Fallback ke browser jika aplikasi Maps tidak tersedia
          final String fallbackUrl = 'https://www.google.com/maps/search/restaurants+near+me';
          final Uri fallbackUri = Uri.parse(fallbackUrl);
          if (await canLaunchUrl(fallbackUri)) {
            await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
          } else {
            _showErrorDialog(context, 'Tidak dapat membuka Maps');
          }
        }
      } else {
        // Fallback untuk platform lain
        googleMapsUrl = 'https://www.google.com/maps/search/restaurants+near+me';
        final Uri mapsUri = Uri.parse(googleMapsUrl);
        if (await canLaunchUrl(mapsUri)) {
          await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
        } else {
          _showErrorDialog(context, 'Tidak dapat membuka Maps');
        }
      }
    } catch (e) {
      _showErrorDialog(context, 'Error: ${e.toString()}');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}