Rails.application.routes.draw do
  post 'twilio/text' => 'twilio#text'
end
