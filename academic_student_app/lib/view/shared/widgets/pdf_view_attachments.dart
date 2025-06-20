import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewAttachment extends StatefulWidget {
  final String title;
  final String url;
  const PdfViewAttachment({super.key, required this.url, required this.title});

  @override
  State<PdfViewAttachment> createState() => _PdfViewAttachmentState();
}

class _PdfViewAttachmentState extends State<PdfViewAttachment> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: white,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.print,
              color: Colors.white,
            ),
            onPressed: isLoading
                ? null
                : () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final value = await http.get(Uri.parse(widget.url));

                        setState(() {
                          isLoading = false;
                        });

                        await Printing.layoutPdf(
                          onLayout: (_) => value.bodyBytes,
                          name: widget.title,
                          dynamicLayout: false,
                        );
                      } catch (e, trace) {
                        CustomDialogs().errorDialog(message: e as String? ?? 'Error Happened');
                        await Sentry.captureException(
                          e,
                          stackTrace: trace,
                        );
                      }
                    }
                  },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SfPdfViewer.network(
              widget.url,
            ),
            if (isLoading)
              Container(
                height: displayHeight(context),
                width: displayWidth(context),
                color: Colors.grey.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
