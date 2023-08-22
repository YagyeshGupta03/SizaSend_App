


//Base apis
const String baseUrl = 'https://server24.in/sizasend/Api/';
const String imageUrl = 'https://server24.in/sizasend/uploads/profile_pic/';
const String videoUrl = 'https://server24.in/sizasend/uploads/order_video/';


//Intro apis
const String signupURl = '${baseUrl}signup';
const String loginUrl = '${baseUrl}login';
const String termsUrl = '${baseUrl}get_terms_and_conditions';

//User profile apis
const String userInfoUrl = '${baseUrl}getUserProfileById';
const String changePasswordUrl = '${baseUrl}changePassword';
const String profileImageUrl = '${baseUrl}update_profile_img';
const String occupationUrl = '${baseUrl}get_all_occupation';
const String updateProfileUrl = '${baseUrl}user_information_update';


//Bank related apis
const String addBankAcUrl = '${baseUrl}add_bank_account';
const String getBankAcUrl = '${baseUrl}getBankByUserId';
const String deleteBankAcUrl = '${baseUrl}deleteBankByBankId';


//Quotation related apis
const String addQuotationUrl = '${baseUrl}add_order';
const String showQuotationUrl = '${baseUrl}getOrderByUserId';
const String deleteQuotationUrl = '${baseUrl}deleteOredrById';
const String editQuotationUrl = '${baseUrl}updateOrdersByOrederId';


