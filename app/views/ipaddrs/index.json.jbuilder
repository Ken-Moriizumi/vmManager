json.array!(@ipaddrs) do |ipaddr|
  json.extract! ipaddr, :ipaddress, :manageno, :macaddress, :use, :remarks
  json.url ipaddr_url(ipaddr, format: :json)
end
