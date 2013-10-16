json.array!(@vminfos) do |vminfo|
  json.extract! vminfo, :name, :path, :ipaddress
  json.url vminfo_url(vminfo, format: :json)
end
