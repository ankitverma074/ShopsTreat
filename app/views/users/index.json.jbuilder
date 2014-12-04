json.array!(@users) do |user|
  json.extract! user, :id, :email, :enc_passwd, :f_name, :l_name, :vendor_flag
  json.url user_url(user, format: :json)
end
