import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssl_app/utils/globals.dart';
import 'package:ssl_app/view/providers/documents_provider.dart';
import 'package:ssl_app/view/usecases/get_doc_type.dart';

typedef DocTypeMenuItem = DropdownMenuItem<DocTypeItem>;

class AddDocument extends StatelessWidget {
  const AddDocument({Key? key}) : super(key: key);

  DocumentProvider get documentProvider => sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: documentProvider, child: const AddDocumentContent());
  }
}

class AddDocumentContent extends StatefulWidget {
  const AddDocumentContent({Key? key}) : super(key: key);

  @override
  State<AddDocumentContent> createState() => _AddDocumentContentState();
}

class _AddDocumentContentState extends State<AddDocumentContent> {
  @override
  void initState() {
    scheduleMicrotask(() async {
      await context.read<DocumentProvider>().getDocTypes();
    });

    super.initState();
  }

  List<DocTypeMenuItem> _getDropDownMenuItem(List<DocTypeItem> items) {
    List<DocTypeMenuItem> menuItems = [];

    for (var item in items) {
      final dropDownItem = DocTypeMenuItem(
        onTap: () {},
        value: item,
        child: SizedBox(
          height: 20,
          child: Text(
            item.documentName,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      );
      menuItems.add(dropDownItem);
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DocumentProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Form(
            key: provider.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!provider.loading) ...[
                  if (provider.submitting) ...[
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                  CustomTextField(
                    labelTexg: 'Subject',
                    controller: provider.subjectController,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Enter a valid subject.';
                      return null;
                    },
                    onChange: (val) {},
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField<DocTypeItem>(
                      items: _getDropDownMenuItem(provider.items),
                      onChanged: (item) {
                        provider.itemSelected(item!);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Document Type',
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                      value: provider.selectedItem,
                      validator: (val) {
                        if (val == null || val.documentID == -1) {
                          return 'please select a valid value';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: DateTimeField(
                      controller: provider.dateTimeFieldController,
                      format: provider.format,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Document date',
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: provider.firstDate,
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: provider.lastDate,
                        );
                      },
                      validator: (date) => date == null ? 'Invalid date' : null,
                      onChanged: (val) {
                        if(val == null) return;
                        provider.dateChanged(provider.format.format(val!));
                      },
                      resetIcon: null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: CustomTextField(
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Invalid Serial Number';
                          return null;
                        },
                        onChange: (val) {
                          provider.serialNumberEntered(val);
                        },
                        keyboardType: TextInputType.number,
                        labelTexg: 'Serial Number',
                        controller: provider.serialNumberController,
                      )),
                      const Text(
                        '/',
                        style: TextStyle(fontSize: 24),
                      ),
                      Expanded(
                          child: CustomTextField(
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Invalid Year.';
                          return null;
                        },
                        onChange: (val) {
                          provider.yearEntered(val);
                        },
                        keyboardType: TextInputType.number,
                        labelTexg: 'Year',
                        controller: provider.yearController,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: MaterialButton(
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            provider.save();
                          },
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: MaterialButton(
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Theme.of(context).primaryColor)),
                            alignment: Alignment.center,
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            provider.clear();
                          },
                        ),
                      ),
                    ],
                  )
                ],
                if (provider.loading) ...[
                  const Center(
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String value) onChange;
  final String? Function(String? value) validator;
  final String labelTexg;
  final TextInputType keyboardType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.labelTexg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelTexg,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
