// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const String logo = 'assets/images/logo.png';
const String home = 'assets/images/nav/1.svg';
const String doctor = 'assets/images/nav/2.svg';
const String filter = 'assets/images/filter.svg';
const String logoDoctor = 'assets/images/doctor.svg';
const String ordersHistory = 'assets/images/orders_history.svg';
const String ordersDay = 'assets/images/orders_day.svg';
const String iconSearch = 'assets/images/search.svg';
const String notification = 'assets/images/notification.svg';
const String sifalo_icon = 'assets/images/x-ray_icon.svg';
const String info_icon = 'assets/images/Info.svg';
const String person = 'assets/images/person.svg';
const String line = 'assets/images/Line.svg';
const String calendar = 'assets/images/Calendar.svg';
const String errorOrderOffline =
    "Exception: Failed to load orders: ClientException with SocketException: Failed host lookup: 'ncbjffnfecycqtlwwgco.supabase.co' (OS Error: No address associated with hostname, errno = 7), uri=https://ncbjffnfecycqtlwwgco.supabase.co/rest/v1/orders?select=order_id%2Cdoctor_id%2Cpatient_id%2Cdate%2Cadditional_notes%2Corder_price%2Corder_output%2Cpatients%28patient_id%2Cpatient_name%2Cage%2Cphone_number%29%2Coutput%3Aorder_output%28id%2Coutput_type%2Cprice%29%2Cexaminationdetails%21inner%28detail_id%2Cprice%2Cmode%3Aexaminationmodes%28mode_id%2Cmode_name%29%2Coption%3Aexaminationoptions%28option_id%2Coption_name%29%2Ctype%3Aexaminationtypes%28examination_type_id%2Ctype_name%29%29&date=gte.2024-12-01T00%3A00%3A00.000&date=lte.2024-12-31T00%3A00%3A00.000";
const String errorOrderOffline2 =
    "Exception: Failed to load orders: ClientException with SocketException: Failed host lookup: 'ncbjffnfecycqtlwwgco.supabase.co' (OS Error: No address associated with hostname, errno = 7)";
const String errorDoctorOffline =
    "Failed to fetch doctors: ClientException with SocketException: Failed host lookup: 'ncbjffnfecycqtlwwgco.supabase.co' (OS Error: No address associated with hostname, errno = 7), uri=https://ncbjffnfecycqtlwwgco.supabase.co/rest/v1/doctors?select=doctor_id%2Cuser_id%2Cdoctor_name%2Cphone_number";
const String errorExamOffline =
    "Exception: Failed to fetch examination details: ClientException with SocketException: Failed host lookup: 'ncbjffnfecycqtlwwgco.supabase.co' (OS Error: No address associated with hostname, errno = 7), uri=https://ncbjffnfecycqtlwwgco.supabase.co/rest/v1/examinationdetails?select=detail_id%2Cprice%2Cmode%3Aexaminationmodes%28mode_id%2Cmode_name%29%2Coption%3Aexaminationoptions%28option_id%2Coption_name%29%2Ctype%3Aexaminationtypes%28examination_type_id%2Ctype_name%29";
const String errorDoctorOrdersHistoryOffline =
    "Exception: Failed to load orders: ClientException with SocketException: Failed host lookup: 'ncbjffnfecycqtlwwgco.supabase.co' (OS Error: No address associated with hostname, errno = 7), uri=https://ncbjffnfecycqtlwwgco.supabase.co/rest/v1/orders?select=order_id%2Cdoctor_id%2Cpatient_id%2Cdate%2Cadditional_notes%2Corder_price%2Corder_output%2Cpatients%28patient_id%2Cpatient_name%2Cage%2Cphone_number%29%2Coutput%3Aorder_output%28id%2Coutput_type%2Cprice%29%2Cexaminationdetails%21inner%28detail_id%2Cprice%2Cmode%3Aexaminationmodes%28mode_id%2Cmode_name%29%2Coption%3Aexaminationoptions%28option_id%2Coption_name%29%2Ctype%3Aexaminationtypes%28examination_type_id%2Ctype_name%29%29&doctor_id=eq.46&date=gte.2024-12-01T00%3A00%3A00.000&date=lte.2024-12-31T00%3A00%3A00.000";
const String offlineIcon = 'assets/images/offline_icon.png';
const String maintenenceIcon = 'assets/images/Maintenence.png';

class AppFont {
  static const primaryFont = 'Cairo';
}

class AppColor {
  static const primaryColor = Color(0xff00AFF3);
  static const secondColor = Color(0xffE3F2FD);
}
