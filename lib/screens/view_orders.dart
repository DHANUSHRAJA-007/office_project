import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:office_project/screens/allorders.dart';
import 'package:office_project/screens/cancelled_order.dart';
import 'package:office_project/screens/delivered_page.dart';
import 'package:office_project/screens/pending_orders.dart';


class ViewOrders extends StatefulWidget {
  const ViewOrders({super.key});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  int selectdIndex = 0;

  final List<String> filters = ["All", "Pending", "Delivered", "Cancelled"];

  String currentDate = DateFormat('dd MMMM yyyy EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " View Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(135),
          child: Container(
            color: Colors.white,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(filters.length, (index) {
                      return ChoiceChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        showCheckmark: false,
                        label: Text(filters[index]),
                        selected: selectdIndex == index,
                        selectedColor: Colors.orange,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: selectdIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (value) {
                          setState(() {
                            selectdIndex = index;
                          });
                          if (index == 0) {}
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 40,
                    width: 450,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SearchBar(
                      elevation: WidgetStatePropertyAll(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      leading: Icon(Icons.search),
                      hintText: "Search Orders",
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat('dd MMM , yyyy EEEE').format(DateTime.now()),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(children: [Expanded(child: getSelectedPage())]),
    );
  }

  Widget getSelectedPage() {
    if (selectdIndex == 0) {
      return Allorders();
    } else if (selectdIndex == 1) {
      return PendingOrders();
    } else if (selectdIndex == 2) {
      return DeliveredPage();
    } else {
      return CancelledOrder();
    }
  }
}
