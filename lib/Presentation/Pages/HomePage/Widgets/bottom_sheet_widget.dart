import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  late TextEditingController _titleTextController;
  late TextEditingController _issuerTextController;
  late TextEditingController _keyTextController;
  late GlobalKey<FormState> _formkey;
  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    _titleTextController = TextEditingController();
    _issuerTextController = TextEditingController();
    _keyTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _issuerTextController.dispose();
    _keyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: TextFormField(
                      key: const Key('title_field'),
                      validator: (val) {
                        if (val == '') {
                          return "Required Field";
                        }
                        return null;
                      },
                      controller: _titleTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hint: Text("Title"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: TextFormField(
                      key: const Key('issuer_field'),
                      controller: _issuerTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hint: Text("Issuer"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: TextFormField(
                      key: Key('key_field'),
                      controller: _keyTextController,
                      validator: (val) {
                        if (val == '') {
                          return "Required Field";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hint: Text("Key"),
                      ),
                    ),
                  ),
                  MaterialButton(
                    key: const Key('add_btn'),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        context.read<HomePageBloc>().add(
                          AddNewAccountEvent(
                            accountEntity: AccountEntity(
                              title: _titleTextController.text,
                              secretKey: _keyTextController.text,
                              issuer: _issuerTextController.text,
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.black,
                    child: Text("Add", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
