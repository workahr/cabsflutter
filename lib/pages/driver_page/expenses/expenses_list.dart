import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../services/cabs_api_service.dart';
import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/rounded_icon_button_widget.dart';
import 'add_expenses.dart';
import 'expenses_delete_model.dart';
import 'expenses_list_model.dart';

class Expenses_List extends StatefulWidget {
  const Expenses_List({Key? key}) : super(key: key);

  @override
  State<Expenses_List> createState() => _Expenses_ListState();
}

class _Expenses_ListState extends State<Expenses_List> {
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  List<ExpensesList>? expensesList;
  List<ExpensesList>? expensesListtAll;
  bool isLoading = false;

  @override
  void initState() {
    getexpensesList();

    super.initState();
  }

  Future getexpensesList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getexpensesList();
    var response = expensesListDataFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        expensesList = response.list;
        expensesListtAll = expensesList;
        isLoading = false;
      });
    } else {
      setState(() {
        expensesList = [];
        expensesListtAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
  }

  Future deleteExpensesById(id) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();
      print('driver delete test $id');
      Map<String, dynamic> postData = {"id": id};
      var result = await apiService.deleteExpensesById(postData);
      ExpensesDeleteModel response = expensesDeleteModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          getexpensesList();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Expenses_List(),
          ),
        );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _drawerKey,
      // drawer: Admin_SideMenu(),
      appBar: AppBar(
        title: const Text(
          'Expenses List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF06234C),
        //automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color to white
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomeTextField(
                          width: MediaQuery.of(context).size.width - 10.0,
                          hint: 'Search Reasons',
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.lightGrey3,
                            size: 20.0,
                          ),
                          labelColor: AppColors.primary,
                          // borderColor: AppColors.primary2,
                          focusBorderColor: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderColor: AppColors.lightGrey3,
                          onChanged: (value) {
                            if (value != '') {
                              print('value $value');
                              value = value.toString().toLowerCase();
                              expensesList = expensesListtAll!
                                  .where((ExpensesList e) =>
                                      e.reasons
                                          .toString()
                                          .toLowerCase()
                                          .contains(value) ||
                                      e.amount
                                          .toString()
                                          .toLowerCase()
                                          .contains(value))
                                  .toList();
                            } else {
                              expensesList = expensesListtAll;
                            }
                            setState(() {});
                          },
                        ),
                        if (expensesList != null)
                          ...expensesList!.map(
                            (ExpensesList e) => Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFFE6EEF8),
                                    child: Icon(Icons.car_repair,
                                        color: Color(0xFF06234C)),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Reason    :  " +
                                              e.reasons.toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Amount   :  " + e.amount.toString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[700]),
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Add_Expenses(
                                                    expenseseditId: e.id,
                                                  ))).then((value) {})
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.red[400]),
                                    onPressed: () => {deleteExpensesById(e.id)},
                                  )
                                ],
                              ),
                            ),
                          )
                      ])),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundedIconButtonWidget(
            title: 'Add Expenses',
            buttonColor: AppColors.primary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Add_Expenses(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
