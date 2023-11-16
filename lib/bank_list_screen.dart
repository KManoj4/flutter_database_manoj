import 'package:flutter/material.dart';
import 'bank_details.dart';
import 'bank_form_screen.dart';
import 'database_helper.dart';
import 'edit_bank_form_screen.dart';
import 'main.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({super.key});

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  late List<BankDetails> _bankDetailsList;

  @override
  void initState() {
    super.initState();
    getAllBankDetails();
  }

  getAllBankDetails() async {
    _bankDetailsList = <BankDetails>[];

    var bankDetails =
        await dbHelper.queryAllRows(DatabaseHelper.bankDetailsTable);

    bankDetails.forEach((bankDetail) {
      setState(() {
        print(bankDetail['_id']);
        print(bankDetail['_bankName']);
        print(bankDetail['_branch']);
        print(bankDetail['_accountType']);
        print(bankDetail['_accountNo']);
        print(bankDetail['_IFSCCode']);

        var bankDetailsModel = BankDetails(
            bankDetail['_id'],
            bankDetail['_bankName'],
            bankDetail['_branch'],
            bankDetail['_accountType'],
            bankDetail['_accountNo'],
            bankDetail['_IFSCCode']);

        _bankDetailsList.add(bankDetailsModel);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              new Expanded(
                  child: new ListView.builder(
                      itemCount: _bankDetailsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new InkWell(
                          onTap: () {
                            print('-------------> List View Clicked  $index');
                            print('-------------> Edit or Delete: Send data');
                            print(_bankDetailsList[index].id);
                            print(_bankDetailsList[index].bankName);
                            print(_bankDetailsList[index].branch);
                            print(_bankDetailsList[index].accountType);
                            print(_bankDetailsList[index].accountNumber);
                            print(_bankDetailsList[index].IFSCCode);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditBankFormScreen(),
                                settings: RouteSettings(
                                  arguments: _bankDetailsList[index],
                                )));
                          },
                          child: Text(_bankDetailsList[index].bankName +
                              '\n' +
                              _bankDetailsList[index].branch +
                              '\n' +
                              _bankDetailsList[index].accountType +
                              '\n' +
                              _bankDetailsList[index].accountNumber +
                              '\n' +
                              _bankDetailsList[index].IFSCCode +
                              '\n'),
                        );
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('---------> FAB Clicked');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BankFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
