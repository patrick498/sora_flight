# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+votes: 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # Find badge by badge_id, badge_id takes presidence over badge
      # grant_on 'users#create', badge_id: 7, badge: 'just-registered', to: :itself

      # If it has 10 comments, grant commenter-10 badge
      # grant_on 'comments#create', badge: 'commenter', level: 10 do |comment|
      #   comment.user.comments.count == 10
      # end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', badge: 'relevant-commenter',
      #   to: :user do |comment|
      #
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', badge: 'autobiographer',
      #   temporary: true, model_name: 'User' do |user|
      #
      #   user.name.length > 4
      # end
      # grant_on 'games#create', badge_id: 1, to: :user do |game|
      #   game.user.games.count > 5
      # end

      # First game
      grant_on 'games#create', badge_id: 1, to: :user do |game|
        game.user.games.count == 1
      end

      # First Correct Guess
      grant_on 'games#create', badge_id: 2, to: :user do |game|
        game.arrival_airport_guess_id.present? &&
          game.arrival_airport_guess_id == game.flight.arrival_airport_id &&
          game.departure_airport_guess_id.present? &&
          game.departure_airport_guess_id == game.flight.departure_airport_id &&
          game.airline_guess_id.present? &&
          game.airline_guess_id == game.flight.airline_id &&
          game.user.games.where(
            arrival_airport_guess_id: game.flight.arrival_airport_id,
            departure_airport_guess_id: game.flight.departure_airport_id,
            airline_guess_id: game.flight.airline_id
          ).count == 1
      end

      # 3 Correct Guesses in a Row
      grant_on 'games#create', badge_id: 3, to: :user do |game|
        last_3_games = game.user.games.order(created_at: :desc).limit(3)
        last_3_games.count == 3 && last_3_games.all? do |g|
          g.arrival_airport_guess_id == g.flight.arrival_airport_id &&
            g.departure_airport_guess_id == g.flight.departure_airport_id &&
            g.airline_guess_id == g.flight.airline_id
        end
      end

      # Played 10 Games
      grant_on 'games#create', badge_id: 4, to: :user do |game|
        game.user.games.count == 10
      end

      # 5 Correct Guesses in a Row
      grant_on 'games#create', badge_id: 5, to: :user do |game|
        last_5_games = game.user.games.order(created_at: :desc).limit(5)
        last_5_games.count == 5 && last_5_games.all? do |g|
          g.arrival_airport_guess_id == g.flight.arrival_airport_id &&
            g.departure_airport_guess_id == g.flight.departure_airport_id &&
            g.airline_guess_id == g.flight.airline_id
        end
      end
    end
  end
end
