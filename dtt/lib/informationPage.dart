import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ABOUT',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp),
          ),
          centerTitle: false,
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'From a student room in 2010 to a full-service digital agency in the heart of Amsterdam. Our story is one of those. A story we are very proud of. '
                  'We - the over 50 enthusiastic strategists, designers, developers and testers - who work together daily on the most beautiful projects. And we have been doing this for small and large clients - from independent entrepreneurs, startups, the public sector and SMEs, to multinationals like Randstad and nonprofits like Greenpeace. '
                  'Clients with diverse objectives, target groups and resources, challenging us time and again to develop a suitable digital solution. As a team, this makes us rich in experience,'
                  'flexible and enormously versatile. And that is precisely where our strength lies.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 32.sp),
                Text(
                  'Design and Development',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                      Image.asset(
                        'assets/images/dtt_banner.png',
                        width: 100.sp,
                        height: 100.sp,
                      ),
                    SizedBox(width: 10.sp),
                    Flexible(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'by DTT',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('https://www.d-tt.nl');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Text(
                            'd-tt.nl',
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.blue,

                            ),
                          ),
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
