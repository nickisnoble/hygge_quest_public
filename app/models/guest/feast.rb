module Guest::Feast
  extend ActiveSupport::Concern

  included do
    enum food_preference: {
      vegetarian: 0,
      duck: 1,
      salmon: 2,
      child: 3
    }
  end

  def feast
    case food_preference
    when "vegetarian"
      "Foraged (V)"
    when "duck"
      "Fowl (Duck)"
    when "salmon"
      "Fish (Salmon)"
    when "child"
      "Child's Feast"
    else
      "Feast TBD"
    end
  end
end