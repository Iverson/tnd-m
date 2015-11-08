class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    can :update, User, id: user.id

    user.role.ability.each do |resource, actions|
      if resource[0] == "_"
        if actions["update"] == "1"
          w = resource.split("_")
          w.shift
          action = "assign_#{w.pop}"
          resource = w.join("_").classify.constantize
        
          can(action.to_sym, resource) 
          # can(:update, resource)
        end
      else
        resource = (resource == "all") ? resource.to_sym : resource.classify.constantize
      end

      actions.each do |action, allowed|
        can(action.to_sym, resource) if allowed == "1"
      end
    end

    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
