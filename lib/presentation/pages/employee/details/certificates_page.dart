import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naseeb/presentation/widgets/w_button.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});
  static const routeName = "/employee/certificates";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Certificates",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WTextField(title: "Certificate name"),
            const SizedBox(
              height: 20,
            ),
            const WTextField(title: "Date"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Files",
              style: TextStyle(color: kgreyColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: kgreyColor),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    tileColor: fieldFocusColor,
                    leading: SvgPicture.asset('assets/svg/PDF.svg'),
                    title: const Text("Sertifikat - Grafik dizayn"),
                    subtitle: const Text("867 Kb . 16 Feb 2022 at 11:30 am"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      color: kprimaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                            color: fieldFocusColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/upload.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Upload your certificate",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: wButton(() => null, "Save", color: kgreyColor),
      ),
    );
  }
}
