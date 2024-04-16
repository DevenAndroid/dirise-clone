import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../model/order_models/model_single_order_response.dart';

class PDFOpener extends StatefulWidget {
  const PDFOpener({super.key, required this.pdfUrl});

  final OrderItem pdfUrl;

  @override
  State<PDFOpener> createState() => _PDFOpenerState();
}

class _PDFOpenerState extends State<PDFOpener> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;

  final TextEditingController searchController = TextEditingController();
  bool showField = false;
  bool vertical = false;
  // bool showLoading = false;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: showField ? 0 : null,
        centerTitle: true,
        leading: showField
            ? const SizedBox.shrink()
            : IconButton(
                onPressed: () {},
                icon: Icon(Icons.adaptive.arrow_back),
              ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: showField
            ? TextFormField(
                onChanged: (v) {
                  if (v.trim().isEmpty) return;
                  // showLoading = true;
                  _searchResult = _pdfViewerController.searchText(v);
                  _searchResult.addListener(() {
                    if (_searchResult.hasResult) {
                      setState(() {});
                    }
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      )),
                  prefixIcon: const Icon(Icons.search),
                  enabled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  fillColor: Colors.white,
                  filled: true,
                ),
              )
            : Text(
          widget.pdfUrl.productName,
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
              ),
        actions: [
          IconButton(
            icon: Icon(
              showField ? Icons.clear : Icons.search,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (_searchResult.hasResult) {
                setState(() {
                  searchController.clear();
                  _searchResult.clear();
                });
              } else {
                showField = !showField;
                setState(() {});
              }
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: () {
                    vertical = !vertical;
                    setState(() {});
                  },
                  child: Text(vertical ? "Page View".tr : "Vertical View".tr))
            ];
          })
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl.virtualProductFile,
        canShowPageLoadingIndicator: true,
        enableTextSelection: true,
        canShowPaginationDialog: false,
        controller: _pdfViewerController,
        currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
        pageLayoutMode: vertical ? PdfPageLayoutMode.continuous : PdfPageLayoutMode.single,
        // scrollDirection: PdfScrollDirection.horizontal
      ),
    );
  }
}
