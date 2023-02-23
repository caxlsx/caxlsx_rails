def mime_type
  Rails.version.to_f >= 5 ? Mime[:xlsx] : Mime::XLSX
end