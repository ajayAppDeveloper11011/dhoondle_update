import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatefulWidget {


  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  Stack(
          children: [
            WebView(
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              onPageStarted: (finish) {
                setState(() {
                  isLoading = true;
                });
              },
              initialUrl:"https://winnersdivine.com/Winners/Webservice/privacypolicy",
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
            ),
            showLoader()
          ],
        ),
      ),
    );
  }
  Widget showLoader(){
    return  Visibility(
      visible: isLoading,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        ),
      ),
    );
  }
}
