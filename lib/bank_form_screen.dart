
import 'main.dart';
import 'database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_manoj/bank_list_screen.dart';

class BankFormScreen extends StatefulWidget {
  const BankFormScreen({super.key});

  @override
  State<BankFormScreen> createState() => _BankFormScreenState();
}

class _BankFormScreenState extends State<BankFormScreen> {

  var _bankNameController = TextEditingController();
  var _branchController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNumberController = TextEditingController();
  var _IFSCCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account Details Form'),
      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 20),
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
              ),),
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
                onPressed: (){
                  print('------------> Save Clicked');
                  _save();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    print('--------------> Save');
    print('--------------> Bank Name: ${_bankNameController.text}');
    print('--------------> Branch: ${_branchController.text}');
    print('--------------> Account Type: ${_accountTypeController.text}');
    print('--------------> Account Number: ${_accountNumberController.text}');
    print('--------------> IFSC Code: ${_IFSCCodeController.text}');


    Map<String, dynamic> row = {
      DatabaseHelper.columnBankName: _bankNameController.text,
      DatabaseHelper.columnBranch: _branchController.text,
      DatabaseHelper.columnAccountType: _accountTypeController.text,
      DatabaseHelper.columnAccountNo: _accountNumberController.text,
      DatabaseHelper.columnIFSCCode: _IFSCCodeController.text,
  };


    final result = await dbHelper.insert(row, DatabaseHelper.bankDetailsTable);

    print('---------------> Insert Result: $result');

    if(result > 0){
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }

    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>BankListScreen()));
    });
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }
}
