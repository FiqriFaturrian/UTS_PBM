import 'package:flutter/material.dart';
import 'package:travo_app_source/core/constants/dimension_constants.dart';
import 'package:travo_app_source/core/helpers/asset_helper.dart';
import 'package:travo_app_source/representation/screen/guest_and_room_screen.dart';
import 'package:travo_app_source/representation/screen/hotels_screen.dart';
import 'package:travo_app_source/representation/screen/select_date_screen.dart';
import 'package:travo_app_source/representation/widgets/app_bar_container.dart';
import 'package:travo_app_source/representation/widgets/item_button_widget.dart';
import 'package:travo_app_source/representation/widgets/item_options_booking.dart';
import 'package:travo_app_source/core/extensions/date_ext.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({Key? key, this.destination}) : super(key: key);

  static const String routeName = '/hotel_booking_screen';

  final String? destination;

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? selectDate;
  String? guestAndRoom;

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Pesan Kamar Hotel',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kMediumPadding * 2,
            ),
            ItemOptionsBookingWidget(
              title: 'Destinasi',
              value: widget.destination ?? 'Viet Nam',
              icon: AssetHelper.icoLocation,
              onTap: () {},
            ),
            ItemOptionsBookingWidget(
              title: 'Pilih Tanggal',
              value: selectDate ?? 'Pilih Tanggal',
              icon: AssetHelper.icoCalendal,
              onTap: () async {
                final result = await Navigator.of(context)
                    .pushNamed(SelectDateScreen.routeName);
                if (result is List<DateTime?>) {
                  setState(() {
                    selectDate =
                        '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                  });
                }
              },
            ),
            ItemOptionsBookingWidget(
              title: 'Jumlah Ruangan',
              value: guestAndRoom ?? 'Jumlah Ruangan',
              icon: AssetHelper.icoBed,
              onTap: () async {
                final result = await Navigator.of(context)
                    .pushNamed(GuestAndRoomScreen.routeName);
                if (result is List<int>) {
                  setState(() {
                    guestAndRoom = '${result[0]} Orang, ${result[1]} Ruangan';
                  });
                }
              },
            ),
            ItemButtonWidget(
              data: 'Cari',
              onTap: () {
                Navigator.of(context).pushNamed(HotelsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
