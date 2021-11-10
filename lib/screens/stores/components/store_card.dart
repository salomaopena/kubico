import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kubico/models/stores/stores.dart';
import 'package:kubico/utils/custom_icon_button.dart';
import 'package:kubico/utils/theme.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({required this.stores});

  final Stores stores;

  @override
  Widget build(BuildContext context) {
    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.yellow;
        case StoreStatus.closed:
          return Colors.red;
        default:
          return Colors.green;
      }
    }

    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "O seu dispositivo não tem suporte para esta funcionalidade..."),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${stores.cleanPhone}')) {
        launch('tel:${stores.cleanPhone}');
      } else {
        showError();
      }
    }

    Future<void> openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                              coords: Coords(stores.address.latitude as double,
                                  stores.address.longitude as double),
                              title: stores.name,
                              description: stores.addressText);
                          Get.back();
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      )
                  ],
                ),
              );
            });
      } catch (e) {
        showError();
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: stores.image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  progressIndicatorBuilder: (_,
                      __,
                      DownloadProgress
                      downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor:
                            const AlwaysStoppedAnimation(
                                Colors.pink),
                          )),
                  errorWidget: (_, __, ___) => Image.asset(
                    'images/logo.png',
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(16))),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      stores.statusText,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorForStatus(stores.status)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        stores.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black),
                      ),
                      Text(
                        stores.addressText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      Text(
                        stores.openingText,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                        icon: Icons.map, color: AppColors.pink, onTap: openMap),
                    CustomIconButton(
                        icon: Icons.phone,
                        color: AppColors.pink,
                        onTap: openPhone),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
