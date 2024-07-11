import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 254, 167, 161),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _additionalMobileNumberController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _donationsController = TextEditingController();
  final _lastDonationDateController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _mobileNumberFocusNode = FocusNode();
  final FocusNode _additionalMobileNumberFocusNode = FocusNode();
  final FocusNode _pinCodeFocusNode = FocusNode();
  final FocusNode _donationsFocusNode = FocusNode();
  final FocusNode _lastDonationDateFocusNode = FocusNode();
  bool _platelets = false;
  bool _drinkingSmoking = false;
  bool _donateBlood = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _additionalMobileNumberController.dispose();
    _pinCodeController.dispose();
    _donationsController.dispose();
    _lastDonationDateController.dispose();
    _fullNameFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _additionalMobileNumberFocusNode.dispose();
    _pinCodeFocusNode.dispose();
    _donationsFocusNode.dispose();
    _lastDonationDateFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _lastDonationDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 59, 58, 58)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: _buildInputDecoration(labelText),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donor Registration'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField(
                controller: _fullNameController,
                focusNode: _fullNameFocusNode,
                labelText: 'Full Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              _buildTextFormField(
                controller: _mobileNumberController,
                focusNode: _mobileNumberFocusNode,
                labelText: 'Mobile Number',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              _buildTextFormField(
                controller: _additionalMobileNumberController,
                focusNode: _additionalMobileNumberFocusNode,
                labelText: 'Additional Mobile Number',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10.0),
              _buildTextFormField(
                controller: _pinCodeController,
                focusNode: _pinCodeFocusNode,
                labelText: 'Pin Code',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text('Platelets Donation', style: TextStyle(color: Color.fromARGB(255, 59, 58, 58))),
                  const SizedBox(width: 10.0),
                  Switch(
                    value: _platelets,
                    onChanged: (value) {
                      setState(() {
                        _platelets = value;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              _buildTextFormField(
                controller: _donationsController,
                focusNode: _donationsFocusNode,
                labelText: 'Number of Donations',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
               const SizedBox(height: 10.0),
              TextFormField(
                controller: _lastDonationDateController,
                decoration: InputDecoration(
                  labelText: 'Last Donation Date',
                  labelStyle: const TextStyle(color: Color.fromARGB(255, 59, 58, 58)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Text('Drinking and Smoking', style: TextStyle(color: Color.fromARGB(255, 59, 58, 58))),
                  const SizedBox(width: 10.0),
                  Switch(
                    value: _drinkingSmoking,
                    onChanged: (value) {
                      setState(() {
                        _drinkingSmoking = value;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Text('Willing to Donate Blood', style: TextStyle(color: Color.fromARGB(255, 59, 58, 58))),
                  const SizedBox(width: 10.0),
                  Switch(
                    value: _donateBlood,
                    onChanged: (value) {
                      setState(() {
                        _donateBlood = value;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: _buildInputDecoration('Blood Donation Experience'),
                maxLines: 4,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 177, 1, 1),
                  foregroundColor: Colors.red,
                ),
                child: const Text('Submit', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
