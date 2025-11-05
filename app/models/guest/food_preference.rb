module Guest::FoodPreference
  extend ActiveSupport::Concern

  included do
    enum :food_preference, {
      vegetarian: 0,
      duck: 1,
      salmon: 2,
      child: 3
    }
  end

  def meal
    case food_preference
    when "vegetarian"
      "Vegetarian"
    when "duck"
      "Duck"
    when "salmon"
      "Salmon"
    when "child"
      "Child's Meal"
    else
      "Not Selected"
    end
  end

  # Keep feast alias for backwards compatibility during transition
  alias_method :feast, :meal
end
