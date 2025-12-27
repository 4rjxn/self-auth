import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';

@RoutePage()
class AccountEditPage extends StatefulWidget {
  final AccountEntity? account;
  const AccountEditPage({super.key, this.account});

  @override
  State<AccountEditPage> createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _issuerController;
  late TextEditingController _keyController;
  late TextEditingController _intervalController;
  late TextEditingController _lengthController;
  bool isUpdate = false;

  @override
  void initState() {
    _titleController = TextEditingController();
    _issuerController = TextEditingController();
    _keyController = TextEditingController();
    _intervalController = TextEditingController();
    _lengthController = TextEditingController();
    if (widget.account != null) {
      isUpdate = true;
      _titleController.text = widget.account!.title;
      _keyController.text = widget.account!.secretKey;
      _issuerController.text = widget.account!.issuer;
      _lengthController.text = widget.account!.length.toString();
      _intervalController.text = widget.account!.interval.toString();
    } else {
      _intervalController.text = "30";
      _lengthController.text = "6";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.w),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Required Field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Title"),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _issuerController,
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Required Field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Issuer"),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _keyController,
                  validator: (str) {
                    if (str == null || str.isEmpty) {
                      return "Required Field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Key"),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownMenu<int>(
                      controller: _intervalController,
                      label: Text("Interval"),
                      dropdownMenuEntries: [
                        DropdownMenuEntry<int>(value: 30, label: "30"),
                        DropdownMenuEntry<int>(value: 60, label: "60"),
                      ],
                    ),
                    DropdownMenu<int>(
                      controller: _lengthController,
                      label: Text("Length"),
                      dropdownMenuEntries: [
                        DropdownMenuEntry<int>(value: 6, label: "6"),
                        DropdownMenuEntry<int>(value: 8, label: "8"),
                        DropdownMenuEntry<int>(value: 10, label: "10"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 80.h),
                MaterialButton(
                  onPressed: () {
                    final bool isValid = _formKey.currentState!.validate();
                    if (isValid && isUpdate) {
                      context.read<HomePageBloc>().add(
                        UpdateAccountEvent(
                          account: AccountEntity(
                            id: widget.account!.id,
                            title: _titleController.text,
                            secretKey: _keyController.text,
                            issuer: _issuerController.text,
                            interval: int.parse(_intervalController.text),
                            length: int.parse(_lengthController.text),
                          ),
                        ),
                      );
                      AutoRouter.of(context).pop();
                    }
                    if (isValid && !isUpdate) {
                      context.read<HomePageBloc>().add(
                        AddNewAccountEvent(
                          accountEntity: AccountEntity(
                            title: _titleController.text,
                            secretKey: _keyController.text,
                            issuer: _issuerController.text,
                            interval: int.parse(_intervalController.text),
                            length: int.parse(_lengthController.text),
                          ),
                        ),
                      );
                      AutoRouter.of(context).pop();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Text(
                    !isUpdate ? "Add Account" : "Update",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _issuerController.dispose();
    _keyController.dispose();
    _intervalController.dispose();
    _lengthController.dispose();
    super.dispose();
  }
}
