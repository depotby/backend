json.tokens do
  json.access @authentication.generate_token_for(:authorization)
  json.refresh @authentication.generate_token_for(:refresh)
end
