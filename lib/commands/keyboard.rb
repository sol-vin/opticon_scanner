require_relative '../command'

# These commands can be found on page U15 in the UMH

class EnablePCWedge < Command
  set_begin_bytes 'KM'
  set_tag :enable_pc_wedge
end

class DisablePCWedge < Command
  set_begin_bytes 'KL'
  set_tag :disable_pc_wedge
end

# These commands can be found on page U16 in the UMH

class KeyLangUS < Command
  set_begin_bytes 'KE'
  set_tag :key_lang_us
end

class KeyLangUK < Command
  set_begin_bytes 'KV'
  set_tag :key_lang_uk
end

class KeyLangDE < Command
  set_begin_bytes 'KG'
  set_tag :key_lang_de
end

class KeyLangFR < Command
  set_begin_bytes 'KI'
  set_tag :key_lang_fr
end

class KeyLangFRMAC < Command
  set_begin_bytes '[BAO'
  set_tag :key_lang_fr_mac
end

class KeyLangIT < Command
  set_begin_bytes 'OW'
  set_tag :key_lang_it
end

class KeyLangMX < Command
  set_begin_bytes 'KJ'
  set_tag :key_lang_mx
end

class KeyLangPT < Command
  set_begin_bytes 'PH'
  set_tag :key_lang_pt
end

class KeyLangCHFR < Command
  set_begin_bytes 'PL'
  set_tag :key_lang_ch_fr
end

# These commands can be found on page U17 in the UMH

class KeyLangCHDE < Command
  set_begin_bytes 'PK'
  set_tag :key_lang_ch_de
end

class KeyLangNL < Command
  set_begin_bytes 'PI'
  set_tag :key_lang_nl
end

class KeyLangSE < Command
  set_begin_bytes 'PD'
  set_tag :key_lang_se
end

class KeyLangFI < Command
  set_begin_bytes 'PG'
  set_tag :key_lang_fi
end

class KeyLangDK < Command
  set_begin_bytes 'KK'
  set_tag :key_lang_dk
end

class KeyLangNO < Command
  set_begin_bytes 'PE'
  set_tag :key_lang_no
end

class KeyLangJP < Command
  set_begin_bytes 'PM'
  set_tag :key_lang_jp
end

class KeyLangCZ < Command
  set_begin_bytes 'WF'
  set_tag :key_lang_cz
end

# These options can be found on page U18 in the UMH

class DisableNumpad < Command
  set_begin_bytes 'RN'
  set_tag :disable_numpad
end

class EnableNumpad < Command
  set_begin_bytes 'RM'
  set_tag :enable_numpad
end

class AutoNumlock < Command
  set_begin_bytes '/A'
  set_tag :auto_numlock
end

class DisableCapsLock < Command
  set_begin_bytes '5Q'
  set_tag :disable_caps_lock
end

class EnableCapsLock < Command
  set_begin_bytes '8A'
  set_tag :enable_caps_lock
end

class AutoCapsLock < Command
  set_begin_bytes '2U'
  set_tag :auto_caps_lock
end

# These commands can be found on page U19 of the UMH

class KeyboardDelayNone < Command
  set_begin_bytes 'LA'
  set_tag :keyboard_delay_none
end

class KeyboardDelay1 < Command
  set_begin_bytes 'LB'
  set_tag :keyboard_delay_1
end

class KeyboardDelay2 < Command
  set_begin_bytes 'LC'
  set_tag :keyboard_delay_2
end

class KeyboardDelay3 < Command
  set_begin_bytes 'LD'
  set_tag :keyboard_delay_3
end

class KeyboardDelay4 < Command
  set_begin_bytes 'LE'
  set_tag :keyboard_delay_4
end

class KeyboardDelay5 < Command
  set_begin_bytes 'LF'
  set_tag :keyboard_delay_5
end

class KeyboardDelay6 < Command
  set_begin_bytes 'LG'
  set_tag :keyboard_delay_6
end

class KeyboardDelay7 < Command
  set_begin_bytes 'LH'
  set_tag :keyboard_delay_7
end

class KeyboardDelay8 < Command
  set_begin_bytes 'LI'
  set_tag :keyboard_delay_8
end

class KeyboardDelay9 < Command
  set_begin_bytes 'LJ'
  set_tag :keyboard_delay_9
end

class KeyboardDelay10 < Command
  set_begin_bytes 'LK'
  set_tag :keyboard_delay_10
end























