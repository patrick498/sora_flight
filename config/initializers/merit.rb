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
    custom_fields: { difficulty: :bronze, icon: "fa-solid fa-star text-warning" }
  )

  Merit::Badge.create!(
    id: 2,
    name: "First Correct",
    description: "Awarded for a correct guess.",
    custom_fields: { difficulty: :silver, icon: "fa-solid fa-check-circle text-success" }
  )

  Merit::Badge.create!(
    id: 3,
    name: "Three Streak",
    description: "Awarded for a streak of correct guesses.",
    custom_fields: { difficulty: :gold, icon: "fa-solid fa-fire text-danger" }
  )

  Merit::Badge.create!(
    id: 4,
    name: "Frequent Player",
    description: "Awarded for playing many games.",
    custom_fields: { difficulty: :silver, icon: "fa-solid fa-user-clock text-muted" }
  )

  Merit::Badge.create!(
    id: 5,
    name: "Five Streak",
    description: "Awarded for guessing correctly every time.",
    custom_fields: { difficulty: :gold, icon: "fa-solid fa-medal text-warning" }
  )

  Merit::Badge.create!(
    id: 6,
    name: "Expert",
    description: "Awarded for reaching 50 correct guesses.",
    custom_fields: { difficulty: :platinum, icon: "fa-solid fa-trophy text-warning" }
  )
end
