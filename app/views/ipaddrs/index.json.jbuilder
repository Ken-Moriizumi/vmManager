json.array!(@ipaddrs) do |ipaddr|
  json.extract! ipaddr, :ipaddress, :manageno, :servername, :macaddress, :use, :remarks
  json.url ipaddr_url(ipaddr, format: :json)
end
