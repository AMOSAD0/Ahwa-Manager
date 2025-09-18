abstract class Drink {
  final String displayName;
  final double basePrice;

  Drink(this.displayName, this.basePrice);

  double getPrice();
}

class Tea extends Drink {
  final String variant;
  Tea({this.variant = "Regular"}) : super("Shai", 5.0);

  @override
  double getPrice() => basePrice + (variant.contains("mint") ? 1.0 : 0.0);
}

class TurkishCoffee extends Drink {
  TurkishCoffee() : super("Turkish Coffee", 8.0);

  @override
  double getPrice() => basePrice;
}
/*
Abstraction + Polymorphism: `Drink` defines a blueprint for drinks, 
while subclasses like `Tea` and `TurkishCoffee` implement their own 
pricing behavior. This allows new drinks to be added without 
modifying existing code.
*/