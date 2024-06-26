class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present?

    can :manage, User, id: user.id
    can :manage, Recipe, user_id: user.id
    can :manage, Food, user_id: user.id
    can :manage, Inventory, user_id: user.id
    can :manage, RecipeFood, recipe: { user_id: user.id }
    can :manage, InventoryFood, inventory: { user_id: user.id }
    can :manage, ShoppingList, recipe: { user_id: user.id }
  end
end
