import 'package:flutter/material.dart';
import 'package:metropole/app/constants/app.colors.dart';
import 'package:metropole/app/routes/app.routes.dart';
import 'package:metropole/common_functions.dart';
import 'package:metropole/core/models/product.model.dart';
import 'package:metropole/presentation/screens/productDetailScreen/product.detail.screen.dart';
import 'package:metropole/presentation/widgets/custom.text.style.dart';
import 'package:metropole/presentation/widgets/dimensions.widget.dart';

Widget productForYou(
    {required snapshot, required themeFlag, required BuildContext context}) {
  return ListView.builder(
    physics: const ScrollPhysics(),
    shrinkWrap: true,
    itemCount: snapshot.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      ProductData prod = snapshot[index];
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.prodDetailRoute,
            arguments: ProductDetailsArgs(id: prod.productId),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            elevation: 6,
            color: themeFlag ? AppColors.mirage : AppColors.creamColor,
            child: Container(
              width: 150,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: Key(prod.productId.toString()),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.165,
                      child: Image.network(
                        prod.productImage,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  vSizedBox1,
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prod.productName,
                          style: CustomTextWidget.bodyText3(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${getProductPrice({
                                'value': int.parse(prod.productPrice)
                              })} сом',
                          style: CustomTextWidget.bodyText3(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
