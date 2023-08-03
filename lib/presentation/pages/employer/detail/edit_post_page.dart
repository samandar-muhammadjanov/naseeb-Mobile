import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:naseeb/blocs/bloc_imports.dart';
import 'package:naseeb/domain/models/address_model.dart';
import 'package:naseeb/domain/repositories/employer_repo/employer_repo.dart';
import 'package:naseeb/domain/repositories/unic_repo/unic_repo.dart';
import 'package:naseeb/presentation/pages/single_screens/map_page.dart';
import 'package:naseeb/presentation/widgets/w_date_picker.dart';
import 'package:naseeb/presentation/widgets/w_loading.dart';
import 'package:naseeb/presentation/widgets/w_textField.dart';
import 'package:naseeb/utils/colors.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage(
      {super.key,
      this.address,
      this.description,
      this.amount,
      this.time,
      this.images,
      this.file,
      this.postId});
  static const routeName = "/employer/edit_post";
  final AddressModel? address;
  final String? description;
  final String? amount;
  final String? time;
  final List? images;
  final File? file;
  final String? postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Post",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, fontFamily: "sfPro"),
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              EmployerBloc()..add(GetPostDetail(postId.toString())),
          child: BlocBuilder<EmployerBloc, EmployerState>(
            builder: (context, state) {
              if (state is EmployerInitial) {
                return buildLoading();
              } else if (state is EmployerLoading) {
                return buildLoading();
              } else if (state is PostDetailLoaded) {
                return Body(
                  state: state,
                  address: address,
                );
              } else if (state is EmployerError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return buildLoading();
              }
            },
          ),
        ));
  }
}

class Body extends StatefulWidget {
  const Body({super.key, required this.state, this.address});
  final PostDetailLoaded state;
  final AddressModel? address;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? image;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  DateTime date = DateTime.now();
  String categoryID = '';
  @override
  void initState() {
    super.initState();
    final item = widget.state.post.data;
    setState(() {
      descriptionController.text = item.description;
      amountController.text = item.amountMoney.toStringAsFixed(0);
      timeController.text = DateFormat("yyyy-MM-dd").format(item.fixedTime);
      addressController.text =
          "${item.addressDto.region}, ${item.addressDto.city}";
      categoryController.text = item.categoryDto.nameUz;
      if (item.responseFiles.isNotEmpty) {
        images.add(item.responseFiles[0].url.split("/").last);
      }
    });
  }

  List images = [];
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    final images = await EmployerRepo().uploadPhotoForPost(imageTemporary.path);
    setState(() {
      this.images = images;
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final item = widget.state.post.data;
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          WTextField(
            title: "Descrition",
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
            controller: descriptionController,
          ),
          const SizedBox(
            height: 10,
          ),
          WTextField(
            title: "Amount",
            controller: amountController,
            type: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          WTextField(
            title: "Time",
            controller: timeController,
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
            onTap: () {
              showDate(
                  date: date,
                  context: context,
                  dateController: timeController,
                  lastDate: DateTime(2030),
                  firstDate: DateTime.now());
            },
            suffix: IconButton(
                onPressed: () {
                  showDate(
                      date: date,
                      context: context,
                      dateController: timeController,
                      lastDate: DateTime(2030),
                      firstDate: DateTime.now());
                },
                icon: const Icon(Icons.date_range_outlined)),
          ),
          const SizedBox(
            height: 10,
          ),
          WTextField(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPage(
                      isForPost: true,
                    ),
                  ));
            },
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
            title: "Address",
            suffix: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(
                        isForPost: true,
                        description: descriptionController.text,
                        birthDate: timeController.text,
                        firstName: amountController.text,
                        images: images,
                        file: image,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.map)),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Category",
            style: TextStyle(color: kgreyColor, fontFamily: "sfPro"),
          ),
          const SizedBox(
            height: 14,
          ),
          TypeAheadFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "*required";
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
                onChanged: (value) async {
                  await UnicRepo().getCategories(value);
                  setState(() {});
                },
                controller: categoryController,
                style: const TextStyle(fontFamily: "sfPro"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: kgreyColor,
                    ),
                  ),
                  fillColor: fieldFocusColor,
                )),
            suggestionsCallback: (pattern) async {
              return await UnicRepo().getCategories(pattern);
            },
            noItemsFoundBuilder: (context) {
              return Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  "No Category",
                  style: TextStyle(fontFamily: "sfPro"),
                ),
              );
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                  title: Text(
                suggestion.nameUz,
                style: const TextStyle(fontFamily: "sfPro"),
              ));
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                categoryController.text = suggestion.nameUz;
                categoryID = suggestion.id.toString();
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Photo",
            style: TextStyle(color: kgreyColor),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              pickImage();
            },
            child: Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kgreyColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    )
                  : item.responseFiles.isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                            item.responseFiles[0].url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                      )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/camera.svg"),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Choose photo from \nyour gallery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "sfPro"),
                            )
                          ],
                        ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              print(images);
              print(item.id);
              EmployerRepo().updatePost(
                  item.id.toString(),
                  descriptionController.text,
                  timeController.text,
                  amountController.text,
                  categoryID.isEmpty ? item.categoryDto.id : categoryID,
                  widget.address == null
                      ? AddressModel(
                          item.addressDto.region,
                          item.addressDto.city,
                          item.addressDto.latitude.toString(),
                          item.addressDto.longitude.toString())
                      : widget.address!,
                  images,
                  context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Save",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "sfPro"),
            ),
          )
        ],
      ),
    );
  }
}
