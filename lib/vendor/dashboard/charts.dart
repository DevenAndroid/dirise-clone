import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/vendor_controllers/vendor_dashboard_controller.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../widgets/dimension_screen.dart';

class DashBoardCharts extends StatefulWidget {
  const DashBoardCharts({super.key});

  @override
  State<DashBoardCharts> createState() => _DashBoardChartsState();
}

class _DashBoardChartsState extends State<DashBoardCharts> {
  final controller = Get.put(VendorDashboardController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.refreshInt.value > 0) {}
      Map<String, dynamic> gg = {};
      if (controller.modelVendorDashboard.dashboard != null) {
        gg = controller.modelVendorDashboard.dashboard!.getJson();
      }
      return SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.25, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: gg.length,
        itemBuilder: (context, index) {
          // if (kDebugMode) {
          //   print("Grid....    $index");
          // }
          return Card(
            margin: EdgeInsets.zero,
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset(imgList[index].toString()),
                  ),
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  Flexible(
                    child: Text(
                      gg.entries.map((e) => e.value).toList()[index].toString(),
                      style: GoogleFonts.poppins(
                          height: 1.5, fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0xFF454B5C)),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      gg.entries.map((e) => e.key.replaceAll("_", " ").capitalize).toList()[index].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(height: 1.5, fontWeight: FontWeight.w500, fontSize: 14, color: const Color(0xFF8C9BB2)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
