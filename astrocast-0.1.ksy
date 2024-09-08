meta:
  id: ax25frames
  endian: be

seq:
  - id: ax25_frame
    type: ax25_frame
    doc-ref: 'https://www.tapr.org/pub_ax25.html'

types:
  ax25_frame:
    seq:
    - id: ax25_header
      type: ax25_header
    - id: payload
      type:
        switch-on: ax25_header.ctl & 0x13
        cases:
          0x03: ui_frame
          0x13: ui_frame
          0x00: i_frame
          0x02: i_frame
          0x10: i_frame
          0x12: i_frame
          #0x11: s_frame

  ax25_header:
    seq:
      - id: dest_callsign_raw
        type: dest_callsign_raw
      - id: dest_ssid_raw
        type: u1
      - id: src_callsign_raw
        type: src_callsign_raw
      - id: src_ssid_raw
        type: u1
      - id: ctl
        type: u1
    instances:
      src_ssid:
        value: (src_ssid_raw & 0x0f) >> 1
      dest_ssid:
        value: (dest_ssid_raw & 0x0f) >> 1
  dest_callsign_raw:
    seq:
      - id: dest_callsign_ror
        process: ror(1)
        size: 6
        type: dest_callsign
  src_callsign_raw:
    seq:
      - id: src_callsign_ror
        process: ror(1)
        type: src_callsign
        size: 6
  dest_callsign:
    seq:
      - id: dest_callsign
        type: str
        encoding: ASCII
        size: 6
  src_callsign:
    seq:
      - id: src_callsign
        type: str
        encoding: ASCII
        size: 6

  i_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        type: ax25_info
        size-eos: true

  ui_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        type: ax25_info
        size-eos: true

  ax25_info:
    seq:
      - id: start_position_data
        type: str
        terminator: 44
        encoding: UTF-8
      - id: time_hh_mm_ss
        type: str
        terminator: 44
        encoding: UTF-8
      - id: valid_notvalid
        type: str
        terminator: 44
        encoding: UTF-8
      - id: latitud_dd_mm
        type: str
        terminator: 44
        encoding: UTF-8
      - id: ns
        type: str
        terminator: 44
        encoding: UTF-8
      - id: longitud_ddd_mm
        type: str
        terminator: 44
        encoding: UTF-8
      - id: ew
        type: str
        terminator: 44
        encoding: UTF-8
      - id: speedoverground
        type: str
        terminator: 44
        encoding: UTF-8
      - id: courseoverground
        type: str
        terminator: 44
        encoding: UTF-8
      - id: date_dd_mm_yy
        type: str
        terminator: 44
        encoding: UTF-8
      - id: magneticvariation
        type: str
        terminator: 44
        encoding: UTF-8
      - id: end_position_data
        type: str
        size: 2
        encoding: UTF-8
      - id: start_house_keeping_data
        type: str
        terminator: 44
        encoding: UTF-8
      - id: timecode_unit_65536_part_of_a_second
        type: str
        terminator: 44
        encoding: UTF-8
      - id: system_voltage_v
        type: str
        terminator: 44
        encoding: UTF-8
      - id: system_current_ma
        type: str
        terminator: 44
        encoding: UTF-8
      - id: system_temperature_c
        type: str
        terminator: 44
        encoding: UTF-8
      - id: rssi
        type: str
        terminator: 44
        encoding: UTF-8
      - id: afc
        type: str
        terminator: 44
        encoding: UTF-8
      - id: flags_format
        type: str
        terminator: 32
        encoding: UTF-8
