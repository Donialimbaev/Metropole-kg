import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metropole/app/constants/app.assets.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/core/notifiers/product.notifier.dart';
import 'package:metropole/core/notifiers/theme.notifier.dart';
import 'package:metropole/presentation/screens/categoryScreen/widgets/category.widget.dart';
import 'package:metropole/presentation/widgets/custom.loader.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';
import 'package:metropole/presentation/widgets/shimmer.effects.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchProductController = TextEditingController();
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).viewInsets.top,
            ),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  elevation: 6,
                  color: themeFlag ? AppColors.mirage : AppColors.creamColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        hSizedBox1,
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: TextField(
                            controller: searchProductController,
                            style: CustomTextWidget.bodyText2(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.rawSienna,
                                ),
                              ),
                              hintText: 'Издөө...',
                              hintStyle: CustomTextWidget.bodyText2(
                                color: themeFlag
                                    ? AppColors.creamColor
                                    : AppColors.mirage,
                              ),
                            ),
                          ),
                        ),
                        hSizedBox1,
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExecuted = true;
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                vSizedBox2,
                isExecuted
                    ? searchData(
                        searchContent: searchProductController.text,
                        themeFlag: themeFlag)
                    : Center(
                        child: Text(
                          'Каалаган нерсеңди изде',
                          style: CustomTextWidget.bodyText2(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchData({required String searchContent, required bool themeFlag}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Consumer<ProductNotifier>(
            builder: (context, notifier, _) {
              return FutureBuilder(
                future: notifier.searchProduct(
                  context: context,
                  productName: searchProductController.text,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerEffects.buildCategoryShimmer(
                        context: context);
                  } else if (!snapshot.hasData) {
                    return customLoader(
                      context: context,
                      themeFlag: themeFlag,
                      text: 'Эч нерсе табылбады !',
                      lottieAsset: AppAssets.error,
                    );
                  } else {
                    var _snapshot = snapshot.data as List;
                    return showDataInGrid(
                        height: MediaQuery.of(context).size.height * 0.17,
                        snapshot: _snapshot,
                        themeFlag: themeFlag,
                        context: context);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
