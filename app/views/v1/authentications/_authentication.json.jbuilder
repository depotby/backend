json.extract! authentication, :id, :status, :created_at, :updated_at

json.browser do
  json.mobile authentication.browser.device.mobile?
  json.name authentication.browser.name
  json.version authentication.browser.version
end
