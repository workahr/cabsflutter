// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/cabs_api_service.dart';

import '../../../services/comFuncService.dart';
import '../../../widgets/custom_text_field.dart';
import 'add_expenses_model.dart';
import 'expenses_edit_model.dart';
import 'expenses_list.dart';
import 'expenses_update_model.dart';

class Add_Expenses extends StatefulWidget {
  int? expenseseditId;
  Add_Expenses({super.key, this.expenseseditId});

  @override
  State<Add_Expenses> createState() => _Add_ExpensesState();
}

class _Add_ExpensesState extends State<Add_Expenses> {
  final _formKey = GlobalKey<FormState>();
  final CabsApiService apiService = CabsApiService();
  final GlobalKey<FormState> addexpensesForm = GlobalKey<FormState>();

  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future saveexpenses() async {
    if (addexpensesForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "booking_id": "",
        "reasons": reasonController.text,
        "amount": amountController.text,
      };
      print('postData $postData');

      var result = await apiService.saveexpenses(postData);
      print('result $result');
      ExpensesAddModel response = expensesAddModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pop(context, {'type': 1});
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
    print('Expenses id :' + widget.expenseseditId.toString());
  }

  refresh() async {
    if (widget.expenseseditId != null) {
      await getExpensesById();
    }
  }

  ExpensesEdit? expensesDetails;

  Future getExpensesById() async {
    await apiService.getBearerToken();

    var result = await apiService.getExpensesById(widget.expenseseditId);
    ExpenseseditModel response = expenseseditModelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        expensesDetails = response.list;

        reasonController.text = expensesDetails!.reasons ?? '';

        amountController.text = expensesDetails!.amount.toString();
      });
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
    }
  }

  Future updateexpenses() async {
    await apiService.getBearerToken();
    if (addexpensesForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "id": widget.expenseseditId,
        "u_booking_id": "",
        "u_reasons": reasonController.text,
        "u_amount": amountController.text
      };
      print("updateexpenses $postData");
      var result = await apiService.updateexpenses(postData);

      ExpensesupdateModel response = expensesupdateModelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
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
    } else {
      showInSnackBar(context, "Please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF193358),
        title: Text(
          widget.expenseseditId == null ? "Add Expenses" : "Update Expenses",
          // 'Third Party Details',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change drawer icon color to white
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.015,
            right: screenWidth * 0.015,
            top: screenHeight * 0.015),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: addexpensesForm,
          child: Column(
            children: [
              CustomeTextField(
                labelText: 'Expenses Reason',
                width: screenWidth * 1,
                control: reasonController,
                type: const TextInputType.numberWithOptions(),
              ),
              CustomeTextField(
                control: amountController,
                // validator: errValidateAddress(addressController.text),
                labelText: 'Amount',
                width: screenWidth * 1,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.expenseseditId == null
                      ? saveexpenses()
                      : updateexpenses();
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  backgroundColor: Color(0xFF06234C),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
