abstract class BaseService<T> {
  final String baseUrl =
      // 'https://fjxhgdvfzl.execute-api.ap-south-1.amazonaws.com/dev/';
      // 'https://8zngcsbdw9.execute-api.ap-south-1.amazonaws.com/dev/';
      'https://hsrgm12suf.execute-api.ap-south-1.amazonaws.com/dev/';

  /// auth repo
  final String signInSignUp = "user/login";
  final String otp = "restaurant/otp";
  final String signUpDetails = "user/manage-user";
  final String getCity = "general/location";
  final String getUserLocation = "location/user-location";
  final String getRestaurantList = "user/restaurant-list";
  final String wishlist = "favourite/manage-favourite";
  final String getCuisine = "user/get_cuisine";
  final String uploadProfilePic = "general/image/upload";
  final String restaurantDetails = "user/restaurant-details";
  final String getUserDetail = "user/manage-user";
  final String editMobileNumber = "user/edit-mobile-number";

  /// order repo
  final String addOrder = "order/manage-order";
  final String offerDetail = "user/offer-details";
  final String menuItems = "user/order-menu-items";
  final String orderResendOtp = "order/otp";
  final String addToCart = "cart/manage-cart";
  final String orderDetail = "user/cart-item";
  final String orderList = "user/view-order";
  final String orderHistory = "user/history";

  /// dine in
  final String bookingOrderDetail = "user/booking-order";

  /// payment
  final String addPayment = "payment/manage-payment";

  /// add rating
  final addRatingUrl = "rating/manage-rating";

  /// food buddy
  final foodBuddy = "user/post";
}
