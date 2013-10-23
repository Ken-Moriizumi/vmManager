class Settings < Settingslogic
  namespace Rails.env
  source Rails.root.join('config', 'application.yml')
end
