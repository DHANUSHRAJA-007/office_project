// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:office_project/screens/accepted_orders.dart';
// import 'package:office_project/screens/cancelled_order.dart';
// import 'package:office_project/screens/delivered_page.dart';
// import 'package:office_project/screens/pending_orders.dart';

// class ViewOrders extends StatefulWidget {
//   const ViewOrders({super.key});

//   @override
//   State<ViewOrders> createState() => _ViewOrdersState();
// }

// class _ViewOrdersState extends State<ViewOrders> {
//   int selectdIndex = 0;

//   final List<String> filters = [
//     "Pending",
//     "Accepted",
//     "Delivered",
//     "Cancelled",
//   ];

//   String currentDate = DateFormat('dd MMMM yyyy EEEE').format(DateTime.now());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           " View Orders",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(70),
//           child: Container(
//             color: Colors.white,

//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: List.generate(filters.length, (index) {
//                       return ChoiceChip(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         showCheckmark: false,
//                         label: Text(filters[index]),
//                         selected: selectdIndex == index,
//                         selectedColor: Colors.green,
//                         backgroundColor: Colors.grey.shade200,
//                         labelStyle: TextStyle(
//                           color: selectdIndex == index
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                         onSelected: (value) {
//                           setState(() {
//                             selectdIndex = index;
//                           });
//                           if (index == 0) {}
//                         },
//                       );
//                     }),
//                   ),
//                   SizedBox(height: 15),
//                   // Container(
//                   //   height: 40,
//                   //   width: 450,
//                   //   decoration: BoxDecoration(
//                   //     border: Border.all(color: Colors.grey),
//                   //     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   //   ),
//                   //   child: SearchBar(
//                   //     elevation: WidgetStatePropertyAll(0),
//                   //     shape: MaterialStateProperty.all(
//                   //       RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(10),
//                   //       ),
//                   //     ),
//                   //     leading: Icon(Icons.search),
//                   //     hintText: "Search Orders",
//                   //   ),
//                   // ),
//                   SizedBox(height: 8),
//                   // Text(
//                   //   DateFormat('dd MMM , yyyy EEEE').format(DateTime.now()),
//                   //   style: TextStyle(fontSize: 16),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Column(children: [Expanded(child: getSelectedPage())]),
//     );
//   }

//   Widget getSelectedPage() {
//     if (selectdIndex == 0) {
//       return PendingOrders();
//     } else if (selectdIndex == 1) {
//       return AcceptedOrders();
//     } else if (selectdIndex == 2) {
//       return DeliveredPage();
//     } else {
//       return CancelledOrder();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/accepted_orders.dart';
import 'package:office_project/screens/cancelled_order.dart';
import 'package:office_project/screens/delivered_page.dart';
import 'package:office_project/screens/pending_orders.dart';

class ViewOrders extends StatefulWidget {
  final String selectedStatus;
  const ViewOrders({super.key, this.selectedStatus = 'pending'});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  int selectdIndex = 0;

  final List<String> filters = [
    "Pending",
    "Accepted",
    "Delivered",
    "Cancelled",
  ];
@override
void didUpdateWidget(covariant ViewOrders oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.selectedStatus != widget.selectedStatus) {
    updateSelectedIndex(widget.selectedStatus);
  }
}
void updateSelectedIndex(String status) {
  switch (status) {
    case 'pending':
      selectdIndex = 0;
      break;
    case 'accepted':
      selectdIndex = 1;
      break;
    case 'delivered':
      selectdIndex = 2;
      break;
    case 'rejected':
      selectdIndex = 3;
      break;
    default:
      selectdIndex = 0;
  }
  setState(() {});
}
@override
void initState() {
  super.initState();
  updateSelectedIndex(widget.selectedStatus);
}
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text(
          "View Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenWidth * 0.25),

          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: 12,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 FILTER CHIPS (SCROLLABLE)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(filters.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          showCheckmark: false,
                          label: Text(filters[index]),
                          selected: selectdIndex == index,
                          selectedColor: Colors.green,
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: selectdIndex == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          onSelected: (value) {
                            setState(() {
                              selectdIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 DATE (RESPONSIVE TEXT)
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: getSelectedPage(),
        ),
      ),
    );
  }

  Widget getSelectedPage() {
    switch (selectdIndex) {
      case 0:
        return const PendingOrders();
      case 1:
        return const AcceptedOrders();
      case 2:
        return const DeliveredPage();
      default:
        return const CancelledOrder();
    }
  }
}
