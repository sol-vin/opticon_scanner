require_relative '../command'

class EnableAztec < Command
  set_begin_bytes '[BCH'
  set_tag :enable_aztec
end

class EnablePDF417 < Command
  set_begin_bytes '[BCF'
  set_tag :enable_pdf417
end

class EnableQR < Command
  set_begin_bytes '[BCD'
  set_tag :enable_qr
end

class EnableDataMatrix < Command
  set_begin_bytes '[BCC'
  set_tag :enable_datamatrix
end

class EnableAll2DCodes < Command
  set_begin_bytes '[BCN'
  set_tag :enable_all_2d_codes
end

class EnableAll1DCodes < Command
  set_begin_bytes '[BCM'
  set_tag :enable_all_1d_codes
end

class EnableAllCodes < Command
  set_begin_bytes EnableAll2DCodes.begin_bytes
  set_end_bytes EnableAll1DCodes.begin_bytes

  set_tag :enable_all_codes
end

class DisableAllCodes < Command
  set_begin_bytes 'B0'
  set_tag :disable_all_codes
end