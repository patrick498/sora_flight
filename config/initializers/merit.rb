# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# Rails.application.reloader.to_prepare do
#   badge_id = 0
#   [{
#     id: (badge_id = badge_id+1),
#     name: 'just-registered'
#   }, {
#     id: (badge_id = badge_id+1),
#     name: 'best-unicorn',
#     custom_fields: { category: 'fantasy' }
#   }].each do |attrs|
#     Merit::Badge.create! attrs
#   end
# end

Rails.application.reloader.to_prepare do
  Merit::Badge.create!(
    id: 1,
    name: "First Game",
    description: "First game played",
    custom_fields: { difficulty: :bronze, icon: "badges/first_game.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 2,
    name: "First Correct",
    description: "Awarded for a correct guess.",
    custom_fields: { difficulty: :silver, icon: "badges/first_correct.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 3,
    name: "Three Streak",
    description: "Awarded for a streak of correct guesses.",
    custom_fields: { difficulty: :gold, icon: "badges/three_streak.png", color: "text-danger" }
  )

  Merit::Badge.create!(
    id: 4,
    name: "Frequent Flyer",
    description: "Awarded for playing over 10 games.",
    custom_fields: { difficulty: :silver, icon: "badges/frequent_flyer.png", color: "text-muted" }
  )

  Merit::Badge.create!(
    id: 5,
    name: "Five Streak",
    description: "Awarded for guessing correctly every time.",
    custom_fields: { difficulty: :gold, icon: "badges/five_streak.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 6,
    name: "Expert",
    description: "Awarded for reaching 50 correct guesses.",
    custom_fields: { difficulty: :platinum, icon: "badges/expert.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 7,
    name: "Co-Pilot",
    description: "Awarded for spotting 10 planes.",
    custom_fields: { difficulty: :platinum, icon: "badges/bronze.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 8,
    name: "Pilot",
    description: "Awarded for spotting 20 planes.",
    custom_fields: { difficulty: :platinum, icon: "badges/silver.png", color: "text-gray" }
  )

  Merit::Badge.create!(
    id: 9,
    name: "Captain",
    description: "Awarded for spotting 30 planes.",
    custom_fields: { difficulty: :platinum, icon: "badges/gold.png", color: "text-warning" }
  )

  Merit::Badge.create!(
    id: 10,
    name: "Airline Spotter",
    description: "Awarded for spotting 10 airlines.",
    custom_fields: { difficulty: :platinum, icon: "badges/airline_spotter.png", color: "text-primary" }
  )

  # FOR DEBUGGING
  Merit::Badge.create!(
    id: 999,
    name: "Second Game",
    description: "Second game played",
    custom_fields: { difficulty: :bronze, icon: "badges/first_game.png", color: "text-warning" }
  )
end
