require 'barby/barcode/code_39'

class OpticonCode39 < Barby::Code39
  # Changes sides to spaces
  def start_encoding; encoding_for_bars([N,W,W,N,N,N,W,N,N]); end
  def stop_encoding; encoding_for_bars([N,W,W,N,N,N,W,N,N]); end
end