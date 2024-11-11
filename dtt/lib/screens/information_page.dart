import 'package:dtt/services/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

/// InformationPage displays brief information about DTT and its official website.

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Builds the InformationPage UI, which includes:
    /// - Brief introduction about the company.
    /// - Company Logo and official clickable website link is shown
    return Scaffold(
        appBar: AppBar(
          title: Text('ABOUT', style: AppTextStyles.titleSemiBold20()),
          centerTitle: false,
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'From a student room in 2010 to a full-service digital agency in the heart of Amsterdam. Our story is one of those. A story we are very proud of. '
                  'We - the over 50 enthusiastic strategists, designers, developers and testers - who work together daily on the most beautiful projects. And we have been doing this for small and large clients - from independent entrepreneurs, startups, the public sector and SMEs, to multinationals like Randstad and nonprofits like Greenpeace. '
                  'Clients with diverse objectives, target groups and resources, challenging us time and again to develop a suitable digital solution. As a team, this makes us rich in experience,'
                  'flexible and enormously versatile. And that is precisely where our strength lies.',
                  style: AppTextStyles.input14(color: Colors.grey[700]!),
                ),
                SizedBox(height: 30.sp),
                Text('Design and Development',
                    style: AppTextStyles.titleSemiBold20()),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/dtt_banner.png',
                      width: 120.sp,
                      height: 120.sp,
                    ),
                    SizedBox(width: 22.sp),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('by DTT',
                              textAlign: TextAlign.left,
                              style: AppTextStyles.input14()),

                          /// Clickable link to DTT's official website using 'urllaucher' packaage.
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri.parse('https://www.d-tt.nl');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Text('d-tt.nl',
                                textAlign: TextAlign.left,
                                style:
                                    AppTextStyles.input14(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
