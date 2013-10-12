RSpec.configure do |config|
  config.include Features::UserHelpers, type: :feature
  config.include Features::TicketHelpers, type: :feature
end
