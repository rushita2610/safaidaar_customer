// ignore_for_file: file_names

const BASEURL = 'https://safaidaar-beta.mydemoapp.us/api/v5/';

const Signup_Api = BASEURL + 'customer/customer-signup';
const Getlanguage_Api = BASEURL + 'get-language';
const Getdropdown_Api = BASEURL + 'dropdown-value';
const Login_Api = BASEURL + 'login?mobile=';
const Checkuser_Api = BASEURL + 'check-user-exists?mobile=';
const SendOTP_Api = BASEURL + 'mobile-verification-otp/send?mobile=';
const VerifyOTP_Api = BASEURL + 'mobile-verification-otp/verify?mobile=';
const placeSearch_Api = BASEURL + "google-place-search";
const Detail_Place_Api = BASEURL + "google-detail-place-search";
const TopService_Api = BASEURL + 'customer/top-services?all=';
const AllTopservices_Api = BASEURL + 'customer/top-services-vendor';
const TopServicevendor_Api = BASEURL + 'customer/top-services-vendor?service_id=';
const FeaturedStore_Api = BASEURL + 'customer/get-featured-vendor';
const Recommended_Api = BASEURL + 'customer/get-recommended-vendor';
const GetCustomerprofile_Api = BASEURL + 'customer/get-customer-profile?user_id=';
const Updatecustomerprofile_Api = BASEURL + "customer/customer-profile-update";
const GetNotificaton_Api = BASEURL + 'get-notification';
const ReadNotification_Api = BASEURL + 'read-notification/';
const GetCustomerorder_Api = BASEURL + 'customer/customer-order';
const GetOffers_Api = BASEURL + 'customer/get-offers';
const GetVendorserviceoffer_Api = BASEURL + 'vendor/get-vendor-service-offers';
const Getpickup_Api = BASEURL + 'get-pickup-dates';
const Pageblock_Api = BASEURL + 'page-block?page_code=';
const GetCustomeraddress_Api = BASEURL + 'customer/customer-address';
const Getsingleaddress_Api = BASEURL + 'customer/customer-address';
const DeleteAddress_Api = BASEURL + 'customer/customer-address';
const Getdeliveryoption_Api = BASEURL + '/get-delivery-options';
const GetVendorservices_Api = BASEURL + 'vendor/get-vendor-services/';
const HomeBanner_Api = BASEURL + 'customer/get-home-banner';
const Feedback_Api = BASEURL + 'help-request';
const Logout_Api = BASEURL + 'logout';