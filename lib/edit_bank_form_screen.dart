import 'main.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_manoj/bank_list_screen.dart';
import 'bank_details.dart';

class EditBankFormScreen extends StatefulWidget {
  const EditBankFormScreen({super.key});

  @override
  State<EditBankFormScreen> createState() => _EditBankFormScreenState();
}

class _EditBankFormScreenState extends State<EditBankFormScreen> {
  var _bankNameController = TextEditingController();
  var _branchController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNumberController = TextEditingController();
  var _IFSCCodeController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedID = 0;

  @override
  Widget build(BuildContext context) {
    if (firstTimeFlag == false) {
      print('---------> Once Executed');
      firstTimeFlag = true;

      final bankDetails =
          ModalRoute.of(context)!.settings.arguments as BankDetails;

      print('-------------->Received Data');
      print(bankDetails.id);
      print(bankDetails.bankName);
      print(bankDetails.branch);
      print(bankDetails.accountType);
      print(bankDetails.accountNumber);
      print(bankDetails.IFSCCode);

      _selectedID = bankDetails.id!;

      _bankNameController.text = bankDetails.bankName;
      _bankNameController.text = bankDetails.branch;
      _bankNameController.text = bankDetails.accountType;
      _bankNameController.text = bankDetails.accountNumber;
      _bankNameController.text = bankDetails.IFSCCode;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account Details Form'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(value: 1, child: Text('Delete')),
            ],
            onSelected: (value){
              if(value == 1){
                print('----------------> Delete - Display Dialog');
                _deleteFormDialog(context);
              }
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: 380,
                  child: TextFormField(
                    controller: _bankNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Bank Name',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: 380,
                  child: TextFormField(
                    controller: _branchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Branch',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: 380,
                  child: TextFormField(
                    controller: _accountTypeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account Type',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: 380,
                  child: TextFormField(
                    controller: _accountNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'Account Number',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: 380,
                  child: TextFormField(
                    controller: _IFSCCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: 'IFSC Code',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  print('------------> Upadate Clicked');
                  _update();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _update() async {
    print('--------------> Update');

    print('--------------> ID: $_selectedID');
    print('--------------> Bank Name: ${_bankNameController.text}');
    print('--------------> Branch: ${_branchController.text}');
    print('--------------> Account Type: ${_accountTypeController.text}');
    print('--------------> Account Number: ${_accountNumberController.text}');
    print('--------------> IFSC Code: ${_IFSCCodeController.text}');

    Map<String, dynamic> row = {

      DatabaseHelper.columnId: _selectedID,
      DatabaseHelper.columnBankName: _bankNameController.text,
      DatabaseHelper.columnBranch: _branchController.text,
      DatabaseHelper.columnAccountType: _accountTypeController.text,
      DatabaseHelper.columnAccountNo: _accountNumberController.text,
      DatabaseHelper.columnIFSCCode: _IFSCCodeController.text,
    };

    final result = await dbHelper.update(row, DatabaseHelper.bankDetailsTable);

    print('---------------> Update Result: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Updated');
    }

    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BankListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (param){
          return AlertDialog(
            actions:<Widget> [
              ElevatedButton(
                  onPressed: (){
                    print('------------> cancel clicked ');
                    Navigator.of(context);
                  },
                  child: Text('Cancel'),
              ),
              ElevatedButton(onPressed: () {
                print('-----------> delete clicked');
                _deleteRow();
              },
                  child: Text('Delete'))
            ],
            title: Text('Are you sure you want to delete this?'),

          );
        });
  }

  void _deleteRow() async {
    print('--------------> Delete');
    // Delete
    print('--------------> ID: $_selectedID');

    final result = await dbHelper.delete(
        _selectedID, DatabaseHelper.bankDetailsTable);

    print('---------------> Deleted Result: $result');


    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Deleted');
    }
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BankListScreen()));
    });
  }

}
