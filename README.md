# Computer Store
Checkout system that can calculate the total price of an order including discounts.

There is no CLI. To see it in action, you can take a look at and run `spec/scenario_spec.rb`.

This solution is built with the intention to make specials flexible so that specials and pricing rules can added/adjusted/removed easily.
- New specials can be declared with minimal code/logic changes by adding a new class to the Specials module (with its own configuration of a pricing rule) and adding it to the all_specials array
- specials can easily be removed by removing them from the all_specials array
- pricing rules can be generated dynamically if required or be created at runtime if desired.
- discounts can be applied to any combination of item bundles
- there can be any number of thresholds for each pricing rule
- The discount amount can be specified per pricing rule.
