


//Base apis
const String baseUrl = 'https://server24.in/sizasend/Api/';
const String imageUrl = 'https://server24.in/sizasend/uploads/profile_pic/';
const String orderImageUrl = 'https://server24.in/sizasend/uploads/order_pic/';
const String videoUrl = 'https://server24.in/sizasend/uploads/order_video/';


//Intro apis
const String signupURl = '${baseUrl}signup';
const String loginUrl = '${baseUrl}login';
const String logoutUrl = '${baseUrl}tokenDeleteById';
const String termsUrl = '${baseUrl}get_terms_and_conditions';
const String privacyUrl = '${baseUrl}get_privacy_policy';


//User profile apis
const String userInfoUrl = '${baseUrl}getUserProfileById';
const String changePasswordUrl = '${baseUrl}changePassword';
const String forgotPasswordUrl = '${baseUrl}passwordUpdateById';
const String profileImageUrl = '${baseUrl}update_profile_img';
const String occupationUrl = '${baseUrl}get_all_occupation';
const String updateProfileUrl = '${baseUrl}user_information_update';
const String buyerListUrl = '${baseUrl}all_quotation_receivers';


//Bank related apis
const String addBankAcUrl = '${baseUrl}add_bank_account';
const String getBankAcUrl = '${baseUrl}getBankByUserId';
const String deleteBankAcUrl = '${baseUrl}deleteBankByBankId';


//Quotation related apis
const String addQuotationUrl = '${baseUrl}add_order';
const String deleteQuotationUrl = '${baseUrl}deleteOredrById';
// const String editQuotationUrl = '${baseUrl}updateOrdersByOrederId';
const String searchUserUrl = '${baseUrl}get_searchByFullnamePhone';
const String receiveQuotationUrl = '${baseUrl}getAllOrders';
const String sendNotificationUrl = '${baseUrl}send_orders_with_notification';
const String receiveNotificationUrl = '${baseUrl}received_notification';
const String notificationStatusUrl = '${baseUrl}notification_status_update';
const String sendQuotationStatusUrl = '${baseUrl}order_status_change';
const String getQuotationDetailsByIdUrl = '${baseUrl}Order_details_by_order_id';
const String getQuotationInvoiceUrl = '${baseUrl}get_all_invoice_details';
const String sendDispatchImageUrl = '${baseUrl}order_send_img';
const String sendDeliveredImageUrl = '${baseUrl}order_receive_img';
const String notificationsDeleteUrl = '${baseUrl}deleteNotificationById';


//Wallet related apis
const String addMoneyUrl = '${baseUrl}add_account_balance';
const String redirectWebUrl = '${baseUrl}redirect_url';
const String withdrawMoneyUrl = '${baseUrl}minus_account_balance';
const String quotationPayUrl = '${baseUrl}user_transaction';
const String quotationPaidStatusUrl = '${baseUrl}paidStatusChange';
const String completeOrderPaymentUrl = '${baseUrl}hold_transaction_add';
const String updateRefundReasonUrl = '${baseUrl}update_order_reason';
const String walletTransactionsUrl = '${baseUrl}get_transaction_history';
const String withdrawRequestUrl = '${baseUrl}get_payment_request';


//Other apis of project
const String contactListUrl = '${baseUrl}get_data_from_contectlist';
const String verifySignNumberUrl = '${baseUrl}number_existing';
const String adminEnquiryUrl = '${baseUrl}add_contect_inquiry';



