abstract final class AppRoutes {
  static const home = '/home';
  static const orders = '/orders';
  static const profile = '/profile';
  static const profileEdit = '/profile/edit';

  static const menuDetail = '/menu/:id';
  static const menuCustomize = '/menu/:id/customize';
  static const cart = '/cart';
  static const orderTracking = '/orders/:id/tracking';

  static String menuPath(String id) => '/menu/${Uri.encodeComponent(id)}';

  static String customizePath(String id) => '${menuPath(id)}/customize';

  static String trackingPath(String id) =>
      '/orders/${Uri.encodeComponent(id)}/tracking';
}
