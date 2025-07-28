; HEADER_BLOCK_START
; BambuStudio 01.10.01.50
; model printing time: 17m 54s; total estimated time: 23m 41s
; total layer number: 86
; total filament length [mm] : 802.71
; total filament volume [cm^3] : 1930.74
; total filament weight [g] : 2.45
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 17.20
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; auxiliary_fan = 1
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\n{else}\nM620.11 S0\n{endif}\nM400\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F[old_filament_e_feedrate]\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\nG92 E0\n{if flush_length_1 > 1}\nM83\n; FLUSH_START\n; always use highest temperature to flush\nM400\n{if filament_type[next_extruder] == "PETG"}\nM109 S260\n{elsif filament_type[next_extruder] == "PVA"}\nM109 S210\n{else}\nM109 S[nozzle_temperature_range_high]\n{endif}\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n\nG91\nG1 X3 F12000; move aside to extrude\nG90\nM83\n\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X105 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\n\nG1 X70 F10000\nG1 X80 F15000\nG1 X60\nG1 X80\nG1 X60\nG1 X80 ; shake to put down garbage\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n
; close_fan_the_first_x_layers = 3
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; curr_bed_type = Textured PEI Plate
; default_acceleration = 10000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL X1C"
; default_jerk = 0
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; enable_arc_fitting = 1
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 0
; enforce_support_layers = 0
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
; ensure_vertical_shell_thickness = 1
; exclude_object = 1
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_offset = 0x2
; extruder_type = DirectDrive
; fan_cooling_layer_time = 30
; fan_max_speed = 90
; fan_min_speed = 40
; filament_colour = #161616
; filament_cost = 30
; filament_density = 1.27
; filament_diameter = 1.75
; filament_end_gcode = "; filament end gcode \nM106 P3 S0\n"
; filament_flow_ratio = 0.95
; filament_ids = GFG99
; filament_is_support = 0
; filament_max_volumetric_speed = 12
; filament_minimal_purge_on_wipe_tower = 15
; filament_notes = 
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_settings_id = "Generic PETG"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_type = PETG
; filament_vendor = Generic
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; host_type = octoprint
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_jerk = 9
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\nM1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 E-[retraction_length] F1800\nG17\nG2 Z{layer_z + 0.4} I0.86 J0.86 P1 F20000 ; spiral lift a little\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 E[retraction_length] F300\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; long_retractions_when_cut = 0
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of "timelapse_record_flag"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,200
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_start_gcode = ;===== machine: P1S ========================\n;===== date: 20231107 =====================\n;===== turn on the HB fan & MC board fan =================\nM104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle\nM710 A1 S255 ;turn on MC fan by default(P1S)\n;===== reset machine status =================\nM290 X40 Y40 Z2.6666666\nG91\nM17 Z0.4 ; lower the z-motor current\nG380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed\nG380 S2 Z-25 F300 ;\nG1 Z5 F300;\nG90\nM17 X1.2 Y1.2 Z0.75 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 5\nM221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\nG29.1 Z{+0.0} ; clear z-trim value first\nM204 S10000 ; init ACC set to 10m/s^2\n\n;===== heatbed preheat ====================\nM1002 gcode_claim_action : 2\nM140 S[bed_temperature_initial_layer_single] ;set bed temp\nM190 S[bed_temperature_initial_layer_single] ;wait for bed temp\n\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n;===== prepare print temperature and material ==========\nM104 S[nozzle_temperature_initial_layer] ;set extruder temp\nG91\nG0 Z10 F1200\nG90\nG28 X\nM975 S1 ; turn on\nG1 X60 F12000\nG1 Y245\nG1 Y265 F3000\nM620 M\nM620 S[initial_extruder]A   ; switch material if AMS exist\n    M109 S[nozzle_temperature_initial_layer]\n    G1 X120 F12000\n\n    G1 X20 Y50 F12000\n    G1 Y-3\n    T[initial_extruder]\n    G1 X54 F12000\n    G1 Y265\n    M400\nM621 S[initial_extruder]A\nM620.1 E F{filament_max_volumetric_speed[initial_extruder]/2.4053*60} T{nozzle_temperature_range_high[initial_extruder]}\n\n\nM412 S1 ; ===turn on filament runout detection===\n\nM109 S250 ;set nozzle to common flush temp\nM106 P1 S0\nG92 E0\nG1 E50 F200\nM400\nM104 S[nozzle_temperature_initial_layer]\nG92 E0\nG1 E50 F200\nM400\nM106 P1 S255\nG92 E0\nG1 E5 F300\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20} ; drop nozzle temp, make filament shink a bit\nG92 E0\nG1 E-0.5 F300\n\nG1 X70 F9000\nG1 X76 F15000\nG1 X65 F15000\nG1 X76 F15000\nG1 X65 F15000; shake to put down garbage\nG1 X80 F6000\nG1 X95 F15000\nG1 X80 F15000\nG1 X165 F15000; wipe and shake\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\nM106 S255\nG1 X65 Y230 F18000\nG1 Y264 F6000\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-20}\nG1 X100 F18000 ; first wipe mouth\n\nG0 X135 Y253 F20000  ; move to exposed steel surface edge\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nG0 Z5 F20000\n\nG1 X60 Y265\nG92 E0\nG1 E-0.5 F300 ; retrack more\nG1 X100 F5000; second wipe mouth\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X100 F5000\nG1 X70 F15000\nG1 X90 F5000\nG0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle\nM104 S140 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM221 S; push soft endstop status\nM221 Z0 ;turn off Z axis endstop\nG0 Z0.5 F20000\nG0 X125 Y259.5 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y262.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y260.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.5\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 Z0.5 F20000\nG0 X125 Y261.0\nG0 Z-1.01\nG0 X131 F211\nG0 X124\nG0 X128\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\nG2 I0.5 J0 F300\n\nM109 S140 ; wait nozzle temp down to heatbed acceptable\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\nG2 I0.5 J0 F3000\n\nM221 R; pop softend status\nG1 Z10 F1200\nM400\nG1 Z10\nG1 F30000\nG1 X230 Y15\nG29.2 S1 ; turn on ABL\n;G28 ; home again after hard wipe mouth\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\nM622 J1\n\n    M1002 gcode_claim_action : 1\n    G29 A X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\n\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n\n\n;=============turn on fans to prevent PLA jamming=================\n{if filament_type[initial_extruder]=="PLA"}\n    {if (bed_temperature[initial_extruder] >45)||(bed_temperature_initial_layer[initial_extruder] >45)}\n    M106 P3 S180\n    {endif};Prevent PLA from jamming\n{endif}\nM106 P2 S100 ; turn on big fan ,to cool down toolhead\n\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; set extrude temp earlier, to reduce wait time\n\n;===== mech mode fast check============================\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q1 A7 B30 C80  H15 K0\nM974 Q1 S2 P0\n\nG1 X128 Y128 Z10 F20000\nM400 P200\nM970.3 Q0 A7 B30 C90 Q0 H15 K0\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X230 Y15\nG28 X ; re-home XY\n;===== fmech mode fast check============================\n\n\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\nG1 X18.0 Y1.0 Z0.8 F18000;Move to start position\nM109 S{nozzle_temperature_initial_layer[initial_extruder]}\nG1 Z0.2\nG0 E2 F300\nG0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}\nG0 X239.5\nG0 E0.2\nG0 Y1.5 E0.700\nG0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type=="Textured PEI Plate"}\nG29.1 Z{-0.04} ; for Textured PEI Plate\n{endif}\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\n
; machine_unload_filament_time = 28
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; nozzle_diameter = 0.4
; nozzle_height = 4.2
; nozzle_temperature = 255
; nozzle_temperature_initial_layer = 255
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 220
; nozzle_type = stainless_steel
; nozzle_volume = 107
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 90
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 50
; post_process = 
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_width = 35
; prime_volume = 45
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_model = Bambu Lab P1S
; printer_notes = 
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = 2
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_inner_walls = 1
; seam_slope_steps = 10
; silent_mode = 0
; single_extruder_multi_material = 1
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 12
; slow_down_min_speed = 20
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 1
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 1
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = normal(auto)
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = 
; timelapse_type = 0
; top_area_threshold = 100%
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; travel_jerk = 9
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = 0
; upward_compatible_machine = "Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; wall_distribution_count = 1
; wall_filament = 1
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 250
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R23
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: P1S ========================
;===== date: 20231107 =====================
;===== turn on the HB fan & MC board fan =================
M104 S75 ;set extruder temp to turn on the HB fan and prevent filament oozing from nozzle
M710 A1 S255 ;turn on MC fan by default(P1S)
;===== reset machine status =================
M290 X40 Y40 Z2.6666666
G91
M17 Z0.4 ; lower the z-motor current
G380 S2 Z30 F300 ; G380 is same as G38; lower the hotbed , to prevent the nozzle is below the hotbed
G380 S2 Z-25 F300 ;
G1 Z5 F300;
G90
M17 X1.2 Y1.2 Z0.75 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 5
M221 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem
G29.1 Z0 ; clear z-trim value first
M204 S10000 ; init ACC set to 10m/s^2

;===== heatbed preheat ====================
M1002 gcode_claim_action : 2
M140 S70 ;set bed temp
M190 S70 ;wait for bed temp



;=============turn on fans to prevent PLA jamming=================

M106 P2 S100 ; turn on big fan ,to cool down toolhead

;===== prepare print temperature and material ==========
M104 S255 ;set extruder temp
G91
G0 Z10 F1200
G90
G28 X
M975 S1 ; turn on
M73 P18 R19
G1 X60 F12000
G1 Y245
G1 Y265 F3000
M620 M
M620 S0A   ; switch material if AMS exist
    M109 S255
    G1 X120 F12000

    G1 X20 Y50 F12000
    G1 Y-3
    T0
    G1 X54 F12000
    G1 Y265
    M400
M621 S0A
M620.1 E F299.339 T270


M412 S1 ; ===turn on filament runout detection===

M109 S250 ;set nozzle to common flush temp
M106 P1 S0
G92 E0
G1 E50 F200
M400
M104 S255
G92 E0
G1 E50 F200
M400
M106 P1 S255
G92 E0
G1 E5 F300
M109 S235 ; drop nozzle temp, make filament shink a bit
G92 E0
M73 P19 R19
G1 E-0.5 F300

M73 P20 R18
G1 X70 F9000
G1 X76 F15000
G1 X65 F15000
G1 X76 F15000
G1 X65 F15000; shake to put down garbage
G1 X80 F6000
G1 X95 F15000
G1 X80 F15000
G1 X165 F15000; wipe and shake
M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1
M106 S255
G1 X65 Y230 F18000
M73 P21 R18
G1 Y264 F6000
M109 S235
G1 X100 F18000 ; first wipe mouth

G0 X135 Y253 F20000  ; move to exposed steel surface edge
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
G0 Z5 F20000

G1 X60 Y265
G92 E0
G1 E-0.5 F300 ; retrack more
G1 X100 F5000; second wipe mouth
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X100 F5000
G1 X70 F15000
G1 X90 F5000
G0 X128 Y261 Z-1.5 F20000  ; move to exposed steel surface and stop the nozzle
M104 S140 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)

M221 S; push soft endstop status
M221 Z0 ;turn off Z axis endstop
G0 Z0.5 F20000
G0 X125 Y259.5 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y262.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y260.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.5
G0 Z-1.01
G0 X131 F211
G0 X124
G0 Z0.5 F20000
G0 X125 Y261.0
G0 Z-1.01
G0 X131 F211
G0 X124
G0 X128
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300
G2 I0.5 J0 F300

M109 S140 ; wait nozzle temp down to heatbed acceptable
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000
G2 I0.5 J0 F3000

M221 R; pop softend status
G1 Z10 F1200
M400
G1 Z10
G1 F30000
G1 X230 Y15
G29.2 S1 ; turn on ABL
;G28 ; home again after hard wipe mouth
M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag
M622 J1

    M1002 gcode_claim_action : 1
    G29 A X119.438 Y119.438 I17.1242 J17.1242
    M400
    M500 ; save cali data

M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623
;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression


;=============turn on fans to prevent PLA jamming=================

M106 P2 S100 ; turn on big fan ,to cool down toolhead


M104 S255 ; set extrude temp earlier, to reduce wait time

;===== mech mode fast check============================
G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q1 A7 B30 C80  H15 K0
M974 Q1 S2 P0

G1 X128 Y128 Z10 F20000
M400 P200
M970.3 Q0 A7 B30 C90 Q0 H15 K0
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X230 Y15
G28 X ; re-home XY
;===== fmech mode fast check============================


;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
M109 S255
G1 Z0.2
G0 E2 F300
G0 X240 E15 F4800
G0 Y11 E0.700 F1200
G0 X239.5
G0 E0.2
G0 Y1.5 E0.700
G0 X18 E15 F4800
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.04 ; for Textured PEI Plate

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
G21
M83 ; use relative distances for extrusion
; filament start gcode
M106 P3 S180


M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
M204 S500
M73 P22 R18
G1 X135.705 Y133.705 F30000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
G1 X120.295 Y133.705 E.55639
G1 X120.295 Y118.295 E.55639
G1 X135.705 Y118.295 E.55639
G1 X135.705 Y133.645 E.55423
G1 X136.162 Y134.162 F30000
; FEATURE: Outer wall
G1 F3000
G1 X119.838 Y134.162 E.5894
G1 X119.838 Y117.838 E.5894
G1 X136.162 Y117.838 E.5894
G1 X136.162 Y134.102 E.58723
; WIPE_START
G1 X134.162 Y134.109 E-.76
; WIPE_END
M73 P23 R18
G1 E-.04 F1800
G1 X134.368 Y126.48 Z.6 F30000
G1 X134.584 Y118.478 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.506845
G1 F3310
G1 X135.316 Y119.211 E.03798
G1 X135.316 Y119.867 E.02404
G1 X134.133 Y118.684 E.06132
G1 X133.477 Y118.684 E.02404
G1 X135.316 Y120.523 E.09532
G1 X135.316 Y121.179 E.02404
G1 X132.821 Y118.684 E.12933
G1 X132.165 Y118.684 E.02404
G1 X135.316 Y121.835 E.16333
G1 X135.316 Y122.491 E.02404
G1 X131.509 Y118.684 E.19733
G1 X130.853 Y118.684 E.02404
G1 X135.316 Y123.147 E.23133
G1 X135.316 Y123.803 E.02404
G1 X130.197 Y118.684 E.26534
G1 X129.541 Y118.684 E.02404
G1 X135.316 Y124.459 E.29934
G1 X135.316 Y125.115 E.02404
G1 X128.885 Y118.684 E.33334
G1 X128.228 Y118.684 E.02404
G1 X135.316 Y125.772 E.36735
G1 X135.316 Y126.428 E.02404
M73 P24 R17
G1 X127.572 Y118.684 E.40135
G1 X126.916 Y118.684 E.02404
G1 X135.316 Y127.084 E.43535
G1 X135.316 Y127.74 E.02404
G1 X126.26 Y118.684 E.46935
G1 X125.604 Y118.684 E.02404
G1 X135.316 Y128.396 E.50336
G1 X135.316 Y129.052 E.02404
G1 X124.948 Y118.684 E.53736
G1 X124.292 Y118.684 E.02404
G1 X135.316 Y129.708 E.57136
G1 X135.316 Y130.364 E.02404
G1 X123.636 Y118.684 E.60536
G1 X122.98 Y118.684 E.02404
G1 X135.316 Y131.02 E.63937
G1 X135.316 Y131.676 E.02404
G1 X122.324 Y118.684 E.67337
G1 X121.668 Y118.684 E.02404
G1 X135.316 Y132.332 E.70737
G1 X135.316 Y132.989 E.02404
G1 X121.011 Y118.684 E.74138
G1 X120.684 Y118.684 E.01202
G1 X120.684 Y119.012 E.01202
G1 X134.988 Y133.316 E.74137
G1 X134.332 Y133.316 E.02404
G1 X120.684 Y119.668 E.70737
G1 X120.684 Y120.324 E.02404
G1 X133.676 Y133.316 E.67336
G1 X133.02 Y133.316 E.02404
G1 X120.684 Y120.98 E.63936
G1 X120.684 Y121.636 E.02404
G1 X132.364 Y133.316 E.60536
G1 X131.708 Y133.316 E.02404
G1 X120.684 Y122.292 E.57136
G1 X120.684 Y122.948 E.02404
G1 X131.052 Y133.316 E.53735
G1 X130.396 Y133.316 E.02404
G1 X120.684 Y123.604 E.50335
G1 X120.684 Y124.26 E.02404
G1 X129.74 Y133.316 E.46935
G1 X129.084 Y133.316 E.02404
G1 X120.684 Y124.916 E.43534
G1 X120.684 Y125.573 E.02404
G1 X128.427 Y133.316 E.40134
G1 X127.771 Y133.316 E.02404
G1 X120.684 Y126.229 E.36734
G1 X120.684 Y126.885 E.02404
G1 X127.115 Y133.316 E.33334
G1 X126.459 Y133.316 E.02404
G1 X120.684 Y127.541 E.29933
G1 X120.684 Y128.197 E.02404
G1 X125.803 Y133.316 E.26533
G1 X125.147 Y133.316 E.02404
G1 X120.684 Y128.853 E.23133
G1 X120.684 Y129.509 E.02404
G1 X124.491 Y133.316 E.19733
G1 X123.835 Y133.316 E.02404
G1 X120.684 Y130.165 E.16332
G1 X120.684 Y130.821 E.02404
G1 X123.179 Y133.316 E.12932
G1 X122.523 Y133.316 E.02404
M73 P25 R17
G1 X120.684 Y131.477 E.09532
G1 X120.684 Y132.133 E.02404
G1 X121.867 Y133.316 E.06132
G1 X121.211 Y133.316 E.02404
G1 X120.478 Y132.584 E.03797
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6300
G1 X121.211 Y133.316 E-.39375
G1 X121.867 Y133.316 E-.24931
G1 X121.649 Y133.099 E-.11694
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M204 S10000
G17
G3 Z.6 I-.073 J1.215 P1  F30000
G1 X135.96 Y133.96 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3907
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3907
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.026 Y133.796 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424039
G1 F3907
G1 X135.627 Y133.195 E.02559
G1 X135.627 Y132.656 E.01623
G1 X134.656 Y133.627 E.04132
G1 X134.117 Y133.627 E.01623
G1 X135.627 Y132.117 E.06427
G1 X135.627 Y131.578 E.01623
G1 X133.578 Y133.627 E.08721
G1 X133.039 Y133.627 E.01623
G1 X135.627 Y131.039 E.11016
G1 X135.627 Y130.5 E.01623
G1 X132.5 Y133.627 E.13311
G1 X131.961 Y133.627 E.01623
G1 X135.627 Y129.961 E.15606
G1 X135.627 Y129.422 E.01623
G1 X131.422 Y133.627 E.179
G1 X130.883 Y133.627 E.01623
G1 X135.627 Y128.883 E.20195
G1 X135.627 Y128.344 E.01623
G1 X130.344 Y133.627 E.2249
G1 X129.805 Y133.627 E.01623
G1 X135.627 Y127.805 E.24785
G1 X135.627 Y127.266 E.01623
G1 X129.266 Y133.627 E.27079
G1 X128.727 Y133.627 E.01623
G1 X135.627 Y126.727 E.29374
G1 X135.627 Y126.188 E.01623
G1 X128.188 Y133.627 E.31669
G1 X127.65 Y133.627 E.01623
G1 X135.627 Y125.65 E.33964
G1 X135.627 Y125.111 E.01623
G1 X127.111 Y133.627 E.36259
G1 X126.572 Y133.627 E.01623
G1 X135.627 Y124.572 E.38553
G1 X135.627 Y124.033 E.01623
G1 X126.033 Y133.627 E.40848
G1 X125.494 Y133.627 E.01623
G1 X135.627 Y123.494 E.43143
G1 X135.627 Y122.955 E.01623
G1 X124.955 Y133.627 E.45438
G1 X124.416 Y133.627 E.01623
G1 X135.627 Y122.416 E.47732
G1 X135.627 Y121.877 E.01623
G1 X123.877 Y133.627 E.50027
G1 X123.338 Y133.627 E.01623
G1 X135.627 Y121.338 E.52322
G1 X135.627 Y120.799 E.01623
G1 X122.799 Y133.627 E.54617
G1 X122.26 Y133.627 E.01623
G1 X135.627 Y120.26 E.56911
G1 X135.627 Y119.721 E.01623
G1 X121.721 Y133.627 E.59206
G1 X121.182 Y133.627 E.01623
G1 X135.627 Y119.182 E.61501
G1 X135.627 Y118.643 E.01623
G1 X120.643 Y133.627 E.63796
G1 X120.373 Y133.627 E.00811
G1 X120.373 Y133.357 E.00811
G1 X135.357 Y118.373 E.63795
G1 X134.818 Y118.373 E.01623
G1 X120.373 Y132.818 E.61501
G1 X120.373 Y132.279 E.01623
G1 X134.279 Y118.373 E.59206
G1 X133.74 Y118.373 E.01623
G1 X120.373 Y131.74 E.56911
G1 X120.373 Y131.201 E.01623
G1 X133.201 Y118.373 E.54616
G1 X132.662 Y118.373 E.01623
G1 X120.373 Y130.662 E.52322
G1 X120.373 Y130.123 E.01623
G1 X132.123 Y118.373 E.50027
G1 X131.584 Y118.373 E.01623
G1 X120.373 Y129.584 E.47732
G1 X120.373 Y129.045 E.01623
G1 X131.045 Y118.373 E.45437
G1 X130.506 Y118.373 E.01623
G1 X120.373 Y128.506 E.43143
G1 X120.373 Y127.967 E.01623
G1 X129.967 Y118.373 E.40848
G1 X129.428 Y118.373 E.01623
G1 X120.373 Y127.428 E.38553
G1 X120.373 Y126.889 E.01623
G1 X128.889 Y118.373 E.36258
G1 X128.35 Y118.373 E.01623
G1 X120.373 Y126.35 E.33963
G1 X120.373 Y125.811 E.01623
G1 X127.811 Y118.373 E.31669
G1 X127.272 Y118.373 E.01623
G1 X120.373 Y125.272 E.29374
G1 X120.373 Y124.733 E.01623
M73 P26 R17
G1 X126.733 Y118.373 E.27079
G1 X126.194 Y118.373 E.01623
G1 X120.373 Y124.194 E.24784
G1 X120.373 Y123.656 E.01623
G1 X125.656 Y118.373 E.2249
G1 X125.117 Y118.373 E.01623
G1 X120.373 Y123.117 E.20195
G1 X120.373 Y122.578 E.01623
G1 X124.578 Y118.373 E.179
G1 X124.039 Y118.373 E.01623
G1 X120.373 Y122.039 E.15605
G1 X120.373 Y121.5 E.01623
G1 X123.5 Y118.373 E.13311
G1 X122.961 Y118.373 E.01623
G1 X120.373 Y120.961 E.11016
G1 X120.373 Y120.422 E.01623
G1 X122.422 Y118.373 E.08721
G1 X121.883 Y118.373 E.01623
G1 X120.373 Y119.883 E.06426
G1 X120.373 Y119.344 E.01623
G1 X121.344 Y118.373 E.04131
G1 X120.805 Y118.373 E.01623
G1 X120.204 Y118.974 E.02559
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9445.868
G1 X120.805 Y118.373 E-.32302
G1 X121.344 Y118.373 E-.20481
G1 X120.912 Y118.805 E-.23216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
G17
G3 Z.8 I-.864 J.857 P1  F30000
G1 X135.96 Y133.96 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3919
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3919
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.068 Y126.7 Z1 F30000
G1 X135.796 Y118.974 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424039
G1 F3919
G1 X135.195 Y118.373 E.02559
G1 X134.656 Y118.373 E.01623
G1 X135.627 Y119.344 E.04132
G1 X135.627 Y119.883 E.01623
G1 X134.117 Y118.373 E.06427
G1 X133.578 Y118.373 E.01623
G1 X135.627 Y120.422 E.08721
G1 X135.627 Y120.961 E.01623
G1 X133.039 Y118.373 E.11016
G1 X132.5 Y118.373 E.01623
G1 X135.627 Y121.5 E.13311
G1 X135.627 Y122.039 E.01623
G1 X131.961 Y118.373 E.15606
G1 X131.422 Y118.373 E.01623
G1 X135.627 Y122.578 E.179
G1 X135.627 Y123.117 E.01623
G1 X130.883 Y118.373 E.20195
G1 X130.344 Y118.373 E.01623
G1 X135.627 Y123.656 E.2249
G1 X135.627 Y124.195 E.01623
G1 X129.805 Y118.373 E.24785
G1 X129.266 Y118.373 E.01623
G1 X135.627 Y124.734 E.27079
G1 X135.627 Y125.273 E.01623
G1 X128.727 Y118.373 E.29374
G1 X128.188 Y118.373 E.01623
G1 X135.627 Y125.812 E.31669
G1 X135.627 Y126.35 E.01623
G1 X127.65 Y118.373 E.33964
G1 X127.111 Y118.373 E.01623
G1 X135.627 Y126.889 E.36259
G1 X135.627 Y127.428 E.01623
G1 X126.572 Y118.373 E.38553
G1 X126.033 Y118.373 E.01623
G1 X135.627 Y127.967 E.40848
G1 X135.627 Y128.506 E.01623
G1 X125.494 Y118.373 E.43143
G1 X124.955 Y118.373 E.01623
G1 X135.627 Y129.045 E.45438
G1 X135.627 Y129.584 E.01623
G1 X124.416 Y118.373 E.47732
G1 X123.877 Y118.373 E.01623
G1 X135.627 Y130.123 E.50027
G1 X135.627 Y130.662 E.01623
G1 X123.338 Y118.373 E.52322
G1 X122.799 Y118.373 E.01623
G1 X135.627 Y131.201 E.54617
G1 X135.627 Y131.74 E.01623
G1 X122.26 Y118.373 E.56911
G1 X121.721 Y118.373 E.01623
G1 X135.627 Y132.279 E.59206
G1 X135.627 Y132.818 E.01623
G1 X121.182 Y118.373 E.61501
G1 X120.643 Y118.373 E.01623
G1 X135.627 Y133.357 E.63796
G1 X135.627 Y133.627 E.00811
G1 X135.357 Y133.627 E.00811
G1 X120.373 Y118.643 E.63795
G1 X120.373 Y119.182 E.01623
G1 X134.818 Y133.627 E.61501
G1 X134.279 Y133.627 E.01623
G1 X120.373 Y119.721 E.59206
G1 X120.373 Y120.26 E.01623
G1 X133.74 Y133.627 E.56911
G1 X133.201 Y133.627 E.01623
G1 X120.373 Y120.799 E.54616
G1 X120.373 Y121.338 E.01623
G1 X132.662 Y133.627 E.52322
G1 X132.123 Y133.627 E.01623
G1 X120.373 Y121.877 E.50027
G1 X120.373 Y122.416 E.01623
G1 X131.584 Y133.627 E.47732
G1 X131.045 Y133.627 E.01623
G1 X120.373 Y122.955 E.45437
G1 X120.373 Y123.494 E.01623
G1 X130.506 Y133.627 E.43143
G1 X129.967 Y133.627 E.01623
G1 X120.373 Y124.033 E.40848
G1 X120.373 Y124.572 E.01623
G1 X129.428 Y133.627 E.38553
G1 X128.889 Y133.627 E.01623
G1 X120.373 Y125.111 E.36258
G1 X120.373 Y125.65 E.01623
G1 X128.35 Y133.627 E.33963
G1 X127.811 Y133.627 E.01623
G1 X120.373 Y126.189 E.31669
G1 X120.373 Y126.728 E.01623
G1 X127.272 Y133.627 E.29374
G1 X126.733 Y133.627 E.01623
G1 X120.373 Y127.267 E.27079
G1 X120.373 Y127.806 E.01623
G1 X126.194 Y133.627 E.24784
G1 X125.656 Y133.627 E.01623
G1 X120.373 Y128.344 E.2249
G1 X120.373 Y128.883 E.01623
G1 X125.117 Y133.627 E.20195
G1 X124.578 Y133.627 E.01623
G1 X120.373 Y129.422 E.179
G1 X120.373 Y129.961 E.01623
M73 P27 R17
G1 X124.039 Y133.627 E.15605
G1 X123.5 Y133.627 E.01623
G1 X120.373 Y130.5 E.13311
G1 X120.373 Y131.039 E.01623
G1 X122.961 Y133.627 E.11016
G1 X122.422 Y133.627 E.01623
G1 X120.373 Y131.578 E.08721
G1 X120.373 Y132.117 E.01623
G1 X121.883 Y133.627 E.06426
G1 X121.344 Y133.627 E.01623
G1 X120.373 Y132.656 E.04131
G1 X120.373 Y133.195 E.01623
G1 X120.974 Y133.796 E.02559
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9445.868
G1 X120.373 Y133.195 E-.32302
G1 X120.373 Y132.656 E-.20481
G1 X120.805 Y133.088 E-.23216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S229.5
G17
G3 Z1 I-.07 J1.215 P1  F30000
G1 X135.96 Y133.96 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S226.95
G17
G3 Z1.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z1.4 F30000
G1 X133.983 Y118.388 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
M73 P28 R17
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S229.5
G17
G3 Z1.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M73 P28 R16
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
M106 S226.95
G17
G3 Z1.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z1.6
M73 P29 R16
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z1.8 F30000
G1 X133.983 Y118.388 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M106 S229.5
G17
G3 Z1.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M73 P30 R16
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M106 S226.95
G17
G3 Z2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z2.2 F30000
M73 P31 R16
G1 X133.983 Y118.388 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S229.5
G17
G3 Z2.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P32 R16
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M106 S226.95
G17
G3 Z2.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
M73 P32 R15
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z2.6 F30000
G1 X133.983 Y118.388 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
M73 P33 R15
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
M106 S229.5
G17
G3 Z2.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z2.6
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
M73 P34 R15
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
M106 S226.95
G17
G3 Z2.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z2.8
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z3 F30000
G1 X133.983 Y118.388 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
M106 S229.5
G17
G3 Z3 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z3
G1 Z2.8
M73 P35 R15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
M106 S226.95
G17
G3 Z3.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z3.2
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
M73 P36 R15
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z3.4 F30000
G1 X133.983 Y118.388 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
M106 S229.5
G17
G3 Z3.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z3.4
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
M73 P36 R14
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P37 R14
G1 X133.983 Y133.612 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
M106 S226.95
G17
G3 Z3.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z3.6
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z3.8 F30000
G1 X133.983 Y118.388 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P38 R14
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S229.5
G17
G3 Z3.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z3.8
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
M73 P39 R14
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
M106 S226.95
G17
G3 Z4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z4
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z4.2 F30000
G1 X133.983 Y118.388 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P40 R14
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
M106 S229.5
G17
G3 Z4.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z4.2
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 21/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
M106 S226.95
G17
G3 Z4.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z4.4
M73 P40 R13
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
M73 P41 R13
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z4.6 F30000
G1 X133.983 Y118.388 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
M106 S229.5
G17
G3 Z4.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z4.6
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
M73 P42 R13
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 23/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
M106 S226.95
G17
G3 Z4.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z4.8
G1 Z4.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z5 F30000
M73 P43 R13
G1 X133.983 Y118.388 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 24/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
M106 S229.5
G17
G3 Z5 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z5
G1 Z4.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z5.2 F30000
G1 Z4.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
M73 P44 R13
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 25/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
M106 S226.95
G17
G3 Z5.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z5.2
G1 Z5
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z5.4 F30000
G1 X133.983 Y118.388 Z5.4
G1 Z5
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
M73 P45 R13
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
M73 P45 R12
G1 E-.04 F1800
; layer num/total_layer_count: 26/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
M106 S229.5
G17
G3 Z5.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z5.4
G1 Z5.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z5.6 F30000
G1 Z5.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
M73 P46 R12
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 27/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
M106 S226.95
G17
G3 Z5.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z5.6
G1 Z5.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z5.8 F30000
G1 X133.983 Y118.388 Z5.8
G1 Z5.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 28/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
M106 S229.5
G17
G3 Z5.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z5.8
G1 Z5.6
G1 E.8 F1800
; FEATURE: Inner wall
M73 P47 R12
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z6 F30000
G1 Z5.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 29/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
M106 S226.95
G17
G3 Z6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z6
G1 Z5.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
M73 P48 R12
G1 E-.04 F1800
G1 X134.175 Y126.669 Z6.2 F30000
G1 X133.983 Y118.388 Z6.2
G1 Z5.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 30/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
M106 S229.5
G17
G3 Z6.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z6.2
G1 Z6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z6.4 F30000
M73 P49 R12
G1 Z6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
M73 P49 R11
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 31/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
M106 S226.95
G17
G3 Z6.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z6.4
G1 Z6.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z6.6 F30000
G1 X133.983 Y118.388 Z6.6
G1 Z6.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
M73 P50 R11
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 32/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
M106 S229.5
G17
G3 Z6.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z6.6
G1 Z6.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z6.8 F30000
G1 Z6.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
M73 P51 R11
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 33/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
M106 S226.95
G17
G3 Z6.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z6.8
G1 Z6.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z7 F30000
G1 X133.983 Y118.388 Z7
G1 Z6.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
M73 P52 R11
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 34/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
M106 S229.5
G17
G3 Z7 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z7
G1 Z6.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z7.2 F30000
G1 Z6.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 35/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
M106 S226.95
G17
G3 Z7.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z7.2
G1 Z7
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M73 P53 R11
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z7.4 F30000
G1 X133.983 Y118.388 Z7.4
G1 Z7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
M73 P53 R10
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 36/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
M106 S229.5
G17
G3 Z7.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z7.4
G1 Z7.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
M73 P54 R10
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z7.6 F30000
G1 Z7.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 37/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
M106 S226.95
G17
G3 Z7.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z7.6
G1 Z7.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z7.8 F30000
G1 X133.983 Y118.388 Z7.8
M73 P55 R10
G1 Z7.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 38/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
M106 S229.5
G17
G3 Z7.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z7.8
G1 Z7.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z8 F30000
G1 Z7.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
M73 P56 R10
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 39/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
M106 S226.95
G17
G3 Z8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z8
G1 Z7.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z8.2 F30000
G1 X133.983 Y118.388 Z8.2
G1 Z7.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
M73 P57 R10
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 40/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
M106 S229.5
G17
G3 Z8.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z8.2
G1 Z8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z8.4 F30000
G1 Z8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
M73 P57 R9
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 41/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
M106 S226.95
G17
M73 P58 R9
G3 Z8.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z8.4
G1 Z8.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z8.6 F30000
G1 X133.983 Y118.388 Z8.6
G1 Z8.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 42/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
M106 S229.5
G17
G3 Z8.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z8.6
G1 Z8.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M73 P59 R9
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z8.8 F30000
G1 Z8.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 43/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
M106 S226.95
G17
G3 Z8.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z8.8
G1 Z8.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P60 R9
G1 X134.175 Y126.669 Z9 F30000
G1 X133.983 Y118.388 Z9
G1 Z8.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 44/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
M106 S229.5
G17
G3 Z9 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z9.2 F30000
M73 P61 R9
G1 Z8.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 45/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
M106 S226.95
G17
G3 Z9.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z9.2
G1 Z9
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z9.4 F30000
G1 X133.983 Y118.388 Z9.4
G1 Z9
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
M73 P62 R9
G1 X120.388 Y126.064 E.2427
M73 P62 R8
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 46/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
M106 S229.5
G17
G3 Z9.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z9.4
G1 Z9.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z9.6 F30000
G1 Z9.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P63 R8
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 47/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
M106 S226.95
G17
G3 Z9.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z9.6
G1 Z9.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z9.8 F30000
G1 X133.983 Y118.388 Z9.8
G1 Z9.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
M73 P64 R8
G1 E-.04 F1800
; layer num/total_layer_count: 48/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
M106 S229.5
G17
G3 Z9.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z9.8
G1 Z9.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z10 F30000
G1 Z9.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 49/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
M106 S226.95
G17
G3 Z10 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z10
G1 Z9.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
M73 P65 R8
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z10.2 F30000
G1 X133.983 Y118.388 Z10.2
G1 Z9.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 50/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
M106 S229.5
G17
G3 Z10.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z10.2
G1 Z10
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
M73 P66 R8
G1 E-.04 F1800
G1 X133.983 Y133.612 Z10.4 F30000
G1 Z10
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
M73 P66 R7
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 51/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
M106 S226.95
G17
G3 Z10.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z10.4
G1 Z10.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z10.6 F30000
G1 X133.983 Y118.388 Z10.6
G1 Z10.2
M73 P67 R7
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 52/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
M106 S229.5
G17
G3 Z10.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z10.6
G1 Z10.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z10.8 F30000
G1 Z10.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
M73 P68 R7
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 53/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
M106 S226.95
G17
G3 Z10.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z10.8
G1 Z10.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z11 F30000
G1 X133.983 Y118.388 Z11
G1 Z10.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
M73 P69 R7
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 54/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
M106 S229.5
G17
G3 Z11 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z11
G1 Z10.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z11.2 F30000
G1 Z10.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 55/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
M106 S226.95
G17
G3 Z11.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z11.2
M73 P70 R7
G1 Z11
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z11.4 F30000
G1 X133.983 Y118.388 Z11.4
G1 Z11
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
M73 P70 R6
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 56/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
M106 S229.5
G17
G3 Z11.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z11.4
G1 Z11.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
M73 P71 R6
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z11.6 F30000
G1 Z11.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 57/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
M106 S226.95
G17
G3 Z11.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z11.6
G1 Z11.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P72 R6
G1 X134.175 Y126.669 Z11.8 F30000
G1 X133.983 Y118.388 Z11.8
G1 Z11.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 58/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
M106 S229.5
G17
G3 Z11.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z11.8
G1 Z11.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z12 F30000
G1 Z11.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P73 R6
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 59/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
M106 S226.95
G17
G3 Z12 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z12
G1 Z11.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z12.2 F30000
G1 X133.983 Y118.388 Z12.2
G1 Z11.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
M73 P74 R6
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 60/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
M106 S229.5
G17
G3 Z12.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z12.2
G1 Z12
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z12.4 F30000
G1 Z12
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P74 R5
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; WIPE_START
M73 P75 R5
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 61/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
M106 S226.95
G17
G3 Z12.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z12.4
G1 Z12.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z12.6 F30000
G1 X133.983 Y118.388 Z12.6
G1 Z12.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 62/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
M106 S229.5
G17
G3 Z12.6 I-.861 J.861 P1  F30000
M73 P76 R5
G1 X135.96 Y133.96 Z12.6
G1 Z12.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z12.8 F30000
G1 Z12.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 63/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
M106 S226.95
G17
G3 Z12.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z12.8
G1 Z12.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
M73 P77 R5
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z13 F30000
G1 X133.983 Y118.388 Z13
G1 Z12.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 64/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
M106 S229.5
G17
G3 Z13 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z13
G1 Z12.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P78 R5
G1 X133.983 Y133.612 Z13.2 F30000
G1 Z12.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 65/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
M106 S226.95
G17
G3 Z13.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z13.2
G1 Z13
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z13.4 F30000
G1 X133.983 Y118.388 Z13.4
M73 P78 R4
G1 Z13
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P79 R4
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 66/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
M106 S229.5
G17
G3 Z13.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z13.4
G1 Z13.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z13.6 F30000
G1 Z13.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
M73 P80 R4
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 67/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
M106 S226.95
G17
G3 Z13.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z13.6
G1 Z13.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z13.8 F30000
G1 X133.983 Y118.388 Z13.8
G1 Z13.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
M73 P81 R4
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 68/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
M106 S229.5
G17
G3 Z13.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z13.8
G1 Z13.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z14 F30000
G1 Z13.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 69/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
M106 S226.95
G17
G3 Z14 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z14
M73 P82 R4
G1 Z13.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z14.2 F30000
G1 X133.983 Y118.388 Z14.2
G1 Z13.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 70/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
M106 S229.5
G17
G3 Z14.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z14.2
G1 Z14
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
M73 P83 R4
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P83 R3
G1 X133.983 Y133.612 Z14.4 F30000
G1 Z14
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 71/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
M106 S226.95
G17
G3 Z14.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z14.4
G1 Z14.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z14.6 F30000
M73 P84 R3
G1 X133.983 Y118.388 Z14.6
G1 Z14.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 72/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
M106 S229.5
G17
G3 Z14.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z14.6
G1 Z14.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z14.8 F30000
G1 Z14.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
M73 P85 R3
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 73/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
M106 S226.95
G17
G3 Z14.8 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z14.8
G1 Z14.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z15 F30000
G1 X133.983 Y118.388 Z15
G1 Z14.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
M73 P86 R3
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 74/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
M106 S229.5
G17
G3 Z15 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z15
G1 Z14.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z15.2 F30000
G1 Z14.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
M73 P87 R3
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 75/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L75
M991 S0 P74 ;notify layer change
M106 S226.95
G17
G3 Z15.2 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z15.2
G1 Z15
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P87 R2
G1 X134.175 Y126.669 Z15.4 F30000
G1 X133.983 Y118.388 Z15.4
G1 Z15
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 76/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L76
M991 S0 P75 ;notify layer change
M106 S229.5
G17
G3 Z15.4 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z15.4
G1 Z15.2
M73 P88 R2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z15.6 F30000
G1 Z15.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 77/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L77
M991 S0 P76 ;notify layer change
M106 S226.95
G17
G3 Z15.6 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z15.6
G1 Z15.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
M73 P89 R2
G1 E-.04 F1800
G1 X134.175 Y126.669 Z15.8 F30000
G1 X133.983 Y118.388 Z15.8
G1 Z15.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 78/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L78
M991 S0 P77 ;notify layer change
M106 S229.5
G17
G3 Z15.8 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z15.8
G1 Z15.6
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P90 R2
G1 X133.983 Y133.612 Z16 F30000
G1 Z15.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 79/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L79
M991 S0 P78 ;notify layer change
M106 S226.95
G17
G3 Z16 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z16
G1 Z15.8
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.175 Y126.669 Z16.2 F30000
G1 X133.983 Y118.388 Z16.2
G1 Z15.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y118.388 E.05236
M73 P91 R2
G1 X120.388 Y133.612 E.6923
G1 X120.388 Y126.064 E.2427
G1 X127.936 Y133.612 E.34323
G1 X128.064 Y133.612 E.00413
G1 X135.612 Y126.064 E.34323
G1 X135.612 Y125.936 E.00413
G1 X128.064 Y118.388 E.34323
G1 X127.936 Y118.388 E.00413
G1 X120.388 Y125.936 E.34323
G1 X120.388 Y118.388 E.2427
G1 X135.612 Y133.612 E.6923
G1 X133.983 Y133.612 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F8843.478
G1 X135.612 Y133.612 E-.61876
G1 X135.349 Y133.349 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 80/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L80
M991 S0 P79 ;notify layer change
M106 S229.5
G17
G3 Z16.2 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z16.2
G1 Z16
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1200
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
M73 P91 R1
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.983 Y133.612 Z16.4 F30000
G1 Z16
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1200
G1 X135.612 Y133.612 E.05236
G1 X120.388 Y118.388 E.6923
G1 X120.388 Y125.936 E.2427
M73 P92 R1
G1 X127.936 Y118.388 E.34323
G1 X128.064 Y118.388 E.00413
G1 X135.612 Y125.936 E.34323
G1 X135.612 Y126.064 E.00413
G1 X128.064 Y133.612 E.34323
G1 X127.936 Y133.612 E.00413
G1 X120.388 Y126.064 E.34323
G1 X120.388 Y133.612 E.2427
G1 X135.612 Y118.388 E.6923
G1 X133.983 Y118.388 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F8843.478
G1 X135.612 Y118.388 E-.61876
G1 X135.349 Y118.651 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 81/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L81
M991 S0 P80 ;notify layer change
M106 S226.95
G17
G3 Z16.4 I-1.216 J.049 P1  F30000
G1 X135.96 Y133.96 Z16.4
G1 Z16.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F1481
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1481
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.954 Y126.691 Z16.6 F30000
G1 X135.597 Y118.562 Z16.6
G1 Z16.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.383213
G1 F1481
G1 X135.57 Y118.43 E.00362
G1 X135.438 Y118.403 E.00362
G1 X120.562 Y118.403 E.39989
G1 X120.43 Y118.43 E.00362
G1 X120.403 Y118.562 E.00362
G1 X120.403 Y133.438 E.39989
G1 X120.43 Y133.57 E.00362
G1 X120.562 Y133.597 E.00362
G1 X135.438 Y133.597 E.39989
G1 X135.57 Y133.57 E.00362
G1 X135.597 Y133.438 E.00362
G1 X135.597 Y118.622 E.39827
G1 X133.606 Y118.765 F30000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1481
M73 P93 R1
G1 X135.235 Y118.765 E.05236
G1 X120.765 Y133.235 E.65801
G1 X120.765 Y126.441 E.21845
G1 X127.559 Y133.235 E.30893
G1 X128.441 Y133.235 E.02838
G1 X135.235 Y126.441 E.30893
G1 X135.235 Y125.559 E.02838
G1 X128.441 Y118.765 E.30893
G1 X127.559 Y118.765 E.02838
G1 X120.765 Y125.559 E.30893
G1 X120.765 Y118.765 E.21845
G1 X135.235 Y133.235 E.65801
G1 X133.606 Y133.235 E.05236
; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F8843.478
G1 X135.235 Y133.235 E-.61876
G1 X134.972 Y132.972 E-.14124
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 82/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L82
M991 S0 P81 ;notify layer change
G17
G3 Z16.6 I-.861 J.861 P1  F30000
G1 X135.96 Y133.96 Z16.6
G1 Z16.4
G1 E.8 F1800
; FEATURE: Inner wall
G1 F7381
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F7381
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.881 Y133.793 Z16.8 F30000
G1 Z16.4
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.401121
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
G1 X135.59 Y133.083 E.05008
G1 X135.59 Y132.445 E.03184
G1 X134.445 Y133.59 E.08082
G1 X133.807 Y133.59 E.03184
G1 X135.59 Y131.807 E.12585
G1 X135.59 Y131.169 E.03184
G1 X133.169 Y133.59 E.17089
G1 X132.531 Y133.59 E.03184
G1 X135.59 Y130.531 E.21592
G1 X135.59 Y129.893 E.03184
G1 X131.893 Y133.59 E.26095
G1 X131.255 Y133.59 E.03184
G1 X135.59 Y129.255 E.30598
G1 X135.59 Y128.617 E.03184
G1 X130.617 Y133.59 E.35101
G1 X129.979 Y133.59 E.03184
G1 X135.59 Y127.979 E.39605
G1 X135.59 Y127.341 E.03184
G1 X129.341 Y133.59 E.44108
M73 P94 R1
G1 X128.703 Y133.59 E.03184
G1 X135.59 Y126.703 E.48611
G1 X135.59 Y126.065 E.03184
G1 X128.065 Y133.59 E.53114
G1 X127.427 Y133.59 E.03184
G1 X135.59 Y125.427 E.57617
G1 X135.59 Y124.789 E.03184
G1 X126.789 Y133.59 E.62121
G1 X126.151 Y133.59 E.03184
G1 X135.59 Y124.151 E.66624
G1 X135.59 Y123.514 E.03184
G1 X125.514 Y133.59 E.71127
G1 X124.876 Y133.59 E.03184
G1 X135.59 Y122.876 E.7563
G1 X135.59 Y122.238 E.03184
G1 X124.238 Y133.59 E.80133
G1 X123.6 Y133.59 E.03184
G1 X135.59 Y121.6 E.84637
G1 X135.59 Y120.962 E.03184
G1 X122.962 Y133.59 E.8914
G1 X122.324 Y133.59 E.03184
G1 X135.59 Y120.324 E.93643
G1 X135.59 Y119.686 E.03184
G1 X121.686 Y133.59 E.98146
G1 X121.048 Y133.59 E.03184
G1 X135.59 Y119.048 E1.02649
G1 X135.59 Y118.41 E.03184
G1 X120.41 Y133.59 E1.07152
G1 X120.41 Y132.952 E.03184
G1 X134.952 Y118.41 E1.02649
G1 X134.314 Y118.41 E.03184
G1 X120.41 Y132.314 E.98145
G1 X120.41 Y131.676 E.03184
G1 X133.676 Y118.41 E.93642
G1 X133.038 Y118.41 E.03184
G1 X120.41 Y131.038 E.89139
G1 X120.41 Y130.4 E.03184
G1 X132.4 Y118.41 E.84636
G1 X131.762 Y118.41 E.03184
G1 X120.41 Y129.762 E.80133
G1 X120.41 Y129.124 E.03184
G1 X131.124 Y118.41 E.75629
G1 X130.486 Y118.41 E.03184
G1 X120.41 Y128.486 E.71126
G1 X120.41 Y127.848 E.03184
G1 X129.848 Y118.41 E.66623
G1 X129.21 Y118.41 E.03184
G1 X120.41 Y127.21 E.6212
G1 X120.41 Y126.572 E.03184
G1 X128.572 Y118.41 E.57617
G1 X127.934 Y118.41 E.03184
G1 X120.41 Y125.934 E.53113
G1 X120.41 Y125.296 E.03184
G1 X127.296 Y118.41 E.4861
G1 X126.658 Y118.41 E.03184
G1 X120.41 Y124.658 E.44107
G1 X120.41 Y124.021 E.03184
G1 X126.021 Y118.41 E.39604
G1 X125.383 Y118.41 E.03184
G1 X120.41 Y123.383 E.35101
G1 X120.41 Y122.745 E.03184
G1 X124.745 Y118.41 E.30597
G1 X124.107 Y118.41 E.03184
G1 X120.41 Y122.107 E.26094
G1 X120.41 Y121.469 E.03184
G1 X123.469 Y118.41 E.21591
G1 X122.831 Y118.41 E.03184
G1 X120.41 Y120.831 E.17088
G1 X120.41 Y120.193 E.03184
G1 X122.193 Y118.41 E.12585
G1 X121.555 Y118.41 E.03184
G1 X120.41 Y119.555 E.08081
G1 X120.41 Y118.917 E.03184
G1 X121.119 Y118.207 E.05008
M106 S226.95
; CHANGE_LAYER
; Z_HEIGHT: 16.6
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F3000
G1 X120.41 Y118.917 E-.38125
G1 X120.41 Y119.555 E-.24243
G1 X120.663 Y119.301 E-.13632
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 83/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L83
M991 S0 P82 ;notify layer change
G17
G3 Z16.8 I-.842 J.879 P1  F30000
G1 X135.96 Y133.96 Z16.8
G1 Z16.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3928
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3928
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.068 Y126.7 Z17 F30000
G1 X135.796 Y118.974 Z17
G1 Z16.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424039
G1 F3928
G1 X135.195 Y118.373 E.02559
G1 X134.656 Y118.373 E.01623
G1 X135.627 Y119.344 E.04132
G1 X135.627 Y119.883 E.01623
G1 X134.117 Y118.373 E.06427
G1 X133.578 Y118.373 E.01623
G1 X135.627 Y120.422 E.08721
G1 X135.627 Y120.961 E.01623
G1 X133.039 Y118.373 E.11016
G1 X132.5 Y118.373 E.01623
G1 X135.627 Y121.5 E.13311
G1 X135.627 Y122.039 E.01623
G1 X131.961 Y118.373 E.15606
G1 X131.422 Y118.373 E.01623
G1 X135.627 Y122.578 E.179
G1 X135.627 Y123.117 E.01623
G1 X130.883 Y118.373 E.20195
G1 X130.344 Y118.373 E.01623
G1 X135.627 Y123.656 E.2249
G1 X135.627 Y124.195 E.01623
M73 P95 R1
G1 X129.805 Y118.373 E.24785
G1 X129.266 Y118.373 E.01623
G1 X135.627 Y124.734 E.27079
G1 X135.627 Y125.273 E.01623
G1 X128.727 Y118.373 E.29374
G1 X128.188 Y118.373 E.01623
G1 X135.627 Y125.812 E.31669
G1 X135.627 Y126.35 E.01623
G1 X127.65 Y118.373 E.33964
G1 X127.111 Y118.373 E.01623
G1 X135.627 Y126.889 E.36259
G1 X135.627 Y127.428 E.01623
G1 X126.572 Y118.373 E.38553
G1 X126.033 Y118.373 E.01623
G1 X135.627 Y127.967 E.40848
G1 X135.627 Y128.506 E.01623
G1 X125.494 Y118.373 E.43143
G1 X124.955 Y118.373 E.01623
G1 X135.627 Y129.045 E.45438
G1 X135.627 Y129.584 E.01623
G1 X124.416 Y118.373 E.47732
G1 X123.877 Y118.373 E.01623
G1 X135.627 Y130.123 E.50027
G1 X135.627 Y130.662 E.01623
G1 X123.338 Y118.373 E.52322
G1 X122.799 Y118.373 E.01623
G1 X135.627 Y131.201 E.54617
G1 X135.627 Y131.74 E.01623
G1 X122.26 Y118.373 E.56911
G1 X121.721 Y118.373 E.01623
G1 X135.627 Y132.279 E.59206
G1 X135.627 Y132.818 E.01623
G1 X121.182 Y118.373 E.61501
G1 X120.643 Y118.373 E.01623
G1 X135.627 Y133.357 E.63796
G1 X135.627 Y133.627 E.00811
G1 X135.357 Y133.627 E.00811
G1 X120.373 Y118.643 E.63795
G1 X120.373 Y119.182 E.01623
G1 X134.818 Y133.627 E.61501
G1 X134.279 Y133.627 E.01623
G1 X120.373 Y119.721 E.59206
G1 X120.373 Y120.26 E.01623
G1 X133.74 Y133.627 E.56911
G1 X133.201 Y133.627 E.01623
G1 X120.373 Y120.799 E.54616
G1 X120.373 Y121.338 E.01623
G1 X132.662 Y133.627 E.52322
G1 X132.123 Y133.627 E.01623
G1 X120.373 Y121.877 E.50027
G1 X120.373 Y122.416 E.01623
G1 X131.584 Y133.627 E.47732
G1 X131.045 Y133.627 E.01623
G1 X120.373 Y122.955 E.45437
G1 X120.373 Y123.494 E.01623
G1 X130.506 Y133.627 E.43143
G1 X129.967 Y133.627 E.01623
G1 X120.373 Y124.033 E.40848
G1 X120.373 Y124.572 E.01623
G1 X129.428 Y133.627 E.38553
G1 X128.889 Y133.627 E.01623
G1 X120.373 Y125.111 E.36258
G1 X120.373 Y125.65 E.01623
G1 X128.35 Y133.627 E.33963
G1 X127.811 Y133.627 E.01623
G1 X120.373 Y126.189 E.31669
G1 X120.373 Y126.728 E.01623
G1 X127.272 Y133.627 E.29374
G1 X126.733 Y133.627 E.01623
G1 X120.373 Y127.267 E.27079
G1 X120.373 Y127.806 E.01623
G1 X126.194 Y133.627 E.24784
G1 X125.656 Y133.627 E.01623
G1 X120.373 Y128.344 E.2249
G1 X120.373 Y128.883 E.01623
G1 X125.117 Y133.627 E.20195
G1 X124.578 Y133.627 E.01623
G1 X120.373 Y129.422 E.179
G1 X120.373 Y129.961 E.01623
G1 X124.039 Y133.627 E.15605
G1 X123.5 Y133.627 E.01623
G1 X120.373 Y130.5 E.13311
G1 X120.373 Y131.039 E.01623
G1 X122.961 Y133.627 E.11016
G1 X122.422 Y133.627 E.01623
G1 X120.373 Y131.578 E.08721
G1 X120.373 Y132.117 E.01623
G1 X121.883 Y133.627 E.06426
G1 X121.344 Y133.627 E.01623
G1 X120.373 Y132.656 E.04131
G1 X120.373 Y133.195 E.01623
G1 X120.974 Y133.796 E.02559
; CHANGE_LAYER
; Z_HEIGHT: 16.8
; LAYER_HEIGHT: 0.199999
; WIPE_START
G1 F9445.868
G1 X120.373 Y133.195 E-.32302
G1 X120.373 Y132.656 E-.20481
G1 X120.805 Y133.088 E-.23216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 84/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L84
M991 S0 P83 ;notify layer change
G17
G3 Z17 I-.07 J1.215 P1  F30000
G1 X135.96 Y133.96 Z17
G1 Z16.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3905
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3905
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.026 Y133.796 Z17.2 F30000
M73 P95 R0
G1 Z16.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424039
G1 F3905
G1 X135.627 Y133.195 E.02559
G1 X135.627 Y132.656 E.01623
G1 X134.656 Y133.627 E.04132
G1 X134.117 Y133.627 E.01623
G1 X135.627 Y132.117 E.06427
G1 X135.627 Y131.578 E.01623
G1 X133.578 Y133.627 E.08721
G1 X133.039 Y133.627 E.01623
G1 X135.627 Y131.039 E.11016
G1 X135.627 Y130.5 E.01623
G1 X132.5 Y133.627 E.13311
G1 X131.961 Y133.627 E.01623
G1 X135.627 Y129.961 E.15606
G1 X135.627 Y129.422 E.01623
G1 X131.422 Y133.627 E.179
G1 X130.883 Y133.627 E.01623
G1 X135.627 Y128.883 E.20195
G1 X135.627 Y128.344 E.01623
G1 X130.344 Y133.627 E.2249
G1 X129.805 Y133.627 E.01623
G1 X135.627 Y127.805 E.24785
G1 X135.627 Y127.266 E.01623
G1 X129.266 Y133.627 E.27079
G1 X128.727 Y133.627 E.01623
G1 X135.627 Y126.727 E.29374
G1 X135.627 Y126.188 E.01623
G1 X128.188 Y133.627 E.31669
G1 X127.65 Y133.627 E.01623
G1 X135.627 Y125.65 E.33964
G1 X135.627 Y125.111 E.01623
G1 X127.111 Y133.627 E.36259
G1 X126.572 Y133.627 E.01623
G1 X135.627 Y124.572 E.38553
G1 X135.627 Y124.033 E.01623
G1 X126.033 Y133.627 E.40848
G1 X125.494 Y133.627 E.01623
G1 X135.627 Y123.494 E.43143
G1 X135.627 Y122.955 E.01623
G1 X124.955 Y133.627 E.45438
G1 X124.416 Y133.627 E.01623
M73 P96 R0
G1 X135.627 Y122.416 E.47732
G1 X135.627 Y121.877 E.01623
G1 X123.877 Y133.627 E.50027
G1 X123.338 Y133.627 E.01623
G1 X135.627 Y121.338 E.52322
G1 X135.627 Y120.799 E.01623
G1 X122.799 Y133.627 E.54617
G1 X122.26 Y133.627 E.01623
G1 X135.627 Y120.26 E.56911
G1 X135.627 Y119.721 E.01623
G1 X121.721 Y133.627 E.59206
G1 X121.182 Y133.627 E.01623
G1 X135.627 Y119.182 E.61501
G1 X135.627 Y118.643 E.01623
G1 X120.643 Y133.627 E.63796
G1 X120.373 Y133.627 E.00811
G1 X120.373 Y133.357 E.00811
G1 X135.357 Y118.373 E.63795
G1 X134.818 Y118.373 E.01623
G1 X120.373 Y132.818 E.61501
G1 X120.373 Y132.279 E.01623
G1 X134.279 Y118.373 E.59206
G1 X133.74 Y118.373 E.01623
G1 X120.373 Y131.74 E.56911
G1 X120.373 Y131.201 E.01623
G1 X133.201 Y118.373 E.54616
G1 X132.662 Y118.373 E.01623
G1 X120.373 Y130.662 E.52322
G1 X120.373 Y130.123 E.01623
G1 X132.123 Y118.373 E.50027
G1 X131.584 Y118.373 E.01623
G1 X120.373 Y129.584 E.47732
G1 X120.373 Y129.045 E.01623
G1 X131.045 Y118.373 E.45437
G1 X130.506 Y118.373 E.01623
G1 X120.373 Y128.506 E.43143
G1 X120.373 Y127.967 E.01623
G1 X129.967 Y118.373 E.40848
G1 X129.428 Y118.373 E.01623
G1 X120.373 Y127.428 E.38553
G1 X120.373 Y126.889 E.01623
G1 X128.889 Y118.373 E.36258
G1 X128.35 Y118.373 E.01623
G1 X120.373 Y126.35 E.33963
G1 X120.373 Y125.811 E.01623
G1 X127.811 Y118.373 E.31669
G1 X127.272 Y118.373 E.01623
G1 X120.373 Y125.272 E.29374
G1 X120.373 Y124.733 E.01623
G1 X126.733 Y118.373 E.27079
G1 X126.194 Y118.373 E.01623
G1 X120.373 Y124.194 E.24784
G1 X120.373 Y123.656 E.01623
G1 X125.656 Y118.373 E.2249
G1 X125.117 Y118.373 E.01623
G1 X120.373 Y123.117 E.20195
G1 X120.373 Y122.578 E.01623
G1 X124.578 Y118.373 E.179
G1 X124.039 Y118.373 E.01623
G1 X120.373 Y122.039 E.15605
G1 X120.373 Y121.5 E.01623
G1 X123.5 Y118.373 E.13311
G1 X122.961 Y118.373 E.01623
G1 X120.373 Y120.961 E.11016
G1 X120.373 Y120.422 E.01623
G1 X122.422 Y118.373 E.08721
G1 X121.883 Y118.373 E.01623
G1 X120.373 Y119.883 E.06426
G1 X120.373 Y119.344 E.01623
G1 X121.344 Y118.373 E.04131
G1 X120.805 Y118.373 E.01623
G1 X120.204 Y118.974 E.02559
; CHANGE_LAYER
; Z_HEIGHT: 17
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F9445.868
G1 X120.805 Y118.373 E-.32302
G1 X121.344 Y118.373 E-.20481
G1 X120.912 Y118.805 E-.23216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 85/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L85
M991 S0 P84 ;notify layer change
G17
G3 Z17.2 I-.864 J.857 P1  F30000
G1 X135.96 Y133.96 Z17.2
G1 Z17
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3919
G1 X120.04 Y133.96 E.51193
G1 X120.04 Y118.04 E.51193
G1 X135.96 Y118.04 E.51193
G1 X135.96 Y133.9 E.51
G1 X136.352 Y134.352 F30000
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3919
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
; WIPE_START
G1 F9547.055
G1 X134.352 Y134.299 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.068 Y126.7 Z17.4 F30000
G1 X135.796 Y118.974 Z17.4
G1 Z17
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.424039
G1 F3919
G1 X135.195 Y118.373 E.02559
G1 X134.656 Y118.373 E.01623
G1 X135.627 Y119.344 E.04132
G1 X135.627 Y119.883 E.01623
G1 X134.117 Y118.373 E.06427
G1 X133.578 Y118.373 E.01623
G1 X135.627 Y120.422 E.08721
G1 X135.627 Y120.961 E.01623
G1 X133.039 Y118.373 E.11016
G1 X132.5 Y118.373 E.01623
G1 X135.627 Y121.5 E.13311
G1 X135.627 Y122.039 E.01623
G1 X131.961 Y118.373 E.15606
G1 X131.422 Y118.373 E.01623
G1 X135.627 Y122.578 E.179
G1 X135.627 Y123.117 E.01623
G1 X130.883 Y118.373 E.20195
G1 X130.344 Y118.373 E.01623
G1 X135.627 Y123.656 E.2249
G1 X135.627 Y124.195 E.01623
G1 X129.805 Y118.373 E.24785
G1 X129.266 Y118.373 E.01623
G1 X135.627 Y124.734 E.27079
G1 X135.627 Y125.273 E.01623
G1 X128.727 Y118.373 E.29374
G1 X128.188 Y118.373 E.01623
G1 X135.627 Y125.812 E.31669
G1 X135.627 Y126.35 E.01623
G1 X127.65 Y118.373 E.33964
G1 X127.111 Y118.373 E.01623
G1 X135.627 Y126.889 E.36259
G1 X135.627 Y127.428 E.01623
G1 X126.572 Y118.373 E.38553
G1 X126.033 Y118.373 E.01623
G1 X135.627 Y127.967 E.40848
G1 X135.627 Y128.506 E.01623
G1 X125.494 Y118.373 E.43143
G1 X124.955 Y118.373 E.01623
G1 X135.627 Y129.045 E.45438
G1 X135.627 Y129.584 E.01623
G1 X124.416 Y118.373 E.47732
G1 X123.877 Y118.373 E.01623
G1 X135.627 Y130.123 E.50027
G1 X135.627 Y130.662 E.01623
G1 X123.338 Y118.373 E.52322
G1 X122.799 Y118.373 E.01623
G1 X135.627 Y131.201 E.54617
G1 X135.627 Y131.74 E.01623
G1 X122.26 Y118.373 E.56911
G1 X121.721 Y118.373 E.01623
G1 X135.627 Y132.279 E.59206
G1 X135.627 Y132.818 E.01623
G1 X121.182 Y118.373 E.61501
G1 X120.643 Y118.373 E.01623
G1 X135.627 Y133.357 E.63796
G1 X135.627 Y133.627 E.00811
G1 X135.357 Y133.627 E.00811
G1 X120.373 Y118.643 E.63795
G1 X120.373 Y119.182 E.01623
M73 P97 R0
G1 X134.818 Y133.627 E.61501
G1 X134.279 Y133.627 E.01623
G1 X120.373 Y119.721 E.59206
G1 X120.373 Y120.26 E.01623
G1 X133.74 Y133.627 E.56911
G1 X133.201 Y133.627 E.01623
G1 X120.373 Y120.799 E.54616
G1 X120.373 Y121.338 E.01623
G1 X132.662 Y133.627 E.52322
G1 X132.123 Y133.627 E.01623
G1 X120.373 Y121.877 E.50027
G1 X120.373 Y122.416 E.01623
G1 X131.584 Y133.627 E.47732
G1 X131.045 Y133.627 E.01623
G1 X120.373 Y122.955 E.45437
G1 X120.373 Y123.494 E.01623
G1 X130.506 Y133.627 E.43143
G1 X129.967 Y133.627 E.01623
G1 X120.373 Y124.033 E.40848
G1 X120.373 Y124.572 E.01623
G1 X129.428 Y133.627 E.38553
G1 X128.889 Y133.627 E.01623
G1 X120.373 Y125.111 E.36258
G1 X120.373 Y125.65 E.01623
G1 X128.35 Y133.627 E.33963
G1 X127.811 Y133.627 E.01623
G1 X120.373 Y126.189 E.31669
G1 X120.373 Y126.728 E.01623
G1 X127.272 Y133.627 E.29374
G1 X126.733 Y133.627 E.01623
G1 X120.373 Y127.267 E.27079
G1 X120.373 Y127.806 E.01623
G1 X126.194 Y133.627 E.24784
G1 X125.656 Y133.627 E.01623
G1 X120.373 Y128.344 E.2249
G1 X120.373 Y128.883 E.01623
G1 X125.117 Y133.627 E.20195
G1 X124.578 Y133.627 E.01623
G1 X120.373 Y129.422 E.179
G1 X120.373 Y129.961 E.01623
G1 X124.039 Y133.627 E.15605
G1 X123.5 Y133.627 E.01623
G1 X120.373 Y130.5 E.13311
G1 X120.373 Y131.039 E.01623
G1 X122.961 Y133.627 E.11016
G1 X122.422 Y133.627 E.01623
G1 X120.373 Y131.578 E.08721
G1 X120.373 Y132.117 E.01623
G1 X121.883 Y133.627 E.06426
G1 X121.344 Y133.627 E.01623
G1 X120.373 Y132.656 E.04131
G1 X120.373 Y133.195 E.01623
G1 X120.974 Y133.796 E.02559
; CHANGE_LAYER
; Z_HEIGHT: 17.2
; LAYER_HEIGHT: 0.200001
; WIPE_START
G1 F9445.868
G1 X120.373 Y133.195 E-.32302
G1 X120.373 Y132.656 E-.20481
G1 X120.805 Y133.088 E-.23216
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 86/86
M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0
M1004 S5 P1  ; external shutter

M623
; update layer progress
M73 L86
M991 S0 P85 ;notify layer change
G17
G3 Z17.4 I-.099 J1.213 P1  F30000
G1 X136.352 Y134.352 Z17.4
G1 Z17.2
G1 E.8 F1800
M204 S5000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4251
G1 X119.648 Y134.352 E.49756
G1 X119.648 Y117.648 E.49756
G1 X136.352 Y117.648 E.49756
G1 X136.352 Y134.292 E.49577
M204 S10000
G1 X135.587 Y134.145 F30000
M204 S2000
; FEATURE: Top surface
G1 F4251
G1 X136.145 Y133.587 E.0235
G1 X136.145 Y133.053
G1 X135.053 Y134.145 E.04597
G1 X134.52 Y134.145
G1 X136.145 Y132.52 E.06843
G1 X136.145 Y131.987
G1 X133.987 Y134.145 E.0909
G1 X133.454 Y134.145
G1 X136.145 Y131.454 E.11336
G1 X136.145 Y130.92
G1 X132.92 Y134.145 E.13582
G1 X132.387 Y134.145
G1 X136.145 Y130.387 E.15829
G1 X136.145 Y129.854
G1 X131.854 Y134.145 E.18075
G1 X131.321 Y134.145
G1 X136.145 Y129.321 E.20322
G1 X136.145 Y128.787
G1 X130.787 Y134.145 E.22568
G1 X130.254 Y134.145
G1 X136.145 Y128.254 E.24814
G1 X136.145 Y127.721
G1 X129.721 Y134.145 E.27061
G1 X129.187 Y134.145
G1 X136.145 Y127.187 E.29307
G1 X136.145 Y126.654
G1 X128.654 Y134.145 E.31553
G1 X128.121 Y134.145
G1 X136.145 Y126.121 E.338
G1 X136.145 Y125.588
G1 X127.588 Y134.145 E.36046
G1 X127.054 Y134.145
G1 X136.145 Y125.054 E.38293
G1 X136.145 Y124.521
G1 X126.521 Y134.145 E.40539
G1 X125.988 Y134.145
G1 X136.145 Y123.988 E.42785
G1 X136.145 Y123.455
G1 X125.455 Y134.145 E.45032
G1 X124.921 Y134.145
G1 X136.145 Y122.921 E.47278
G1 X136.145 Y122.388
G1 X124.388 Y134.145 E.49524
G1 X123.855 Y134.145
G1 X136.145 Y121.855 E.51771
G1 X136.145 Y121.321
G1 X123.321 Y134.145 E.54017
G1 X122.788 Y134.145
G1 X136.145 Y120.788 E.56264
G1 X136.145 Y120.255
G1 X122.255 Y134.145 E.5851
G1 X121.722 Y134.145
G1 X136.145 Y119.722 E.60756
G1 X136.145 Y119.188
G1 X121.188 Y134.145 E.63003
G1 X120.655 Y134.145
G1 X136.145 Y118.655 E.65249
G1 X136.145 Y118.122
G1 X120.122 Y134.145 E.67495
G1 X119.855 Y133.878
G1 X135.878 Y117.855 E.67495
G1 X135.345 Y117.855
G1 X119.855 Y133.345 E.65249
G1 X119.855 Y132.811
G1 X134.811 Y117.855 E.63002
G1 X134.278 Y117.855
G1 X119.855 Y132.278 E.60756
G1 X119.855 Y131.745
G1 X133.745 Y117.855 E.58509
G1 X133.212 Y117.855
G1 X119.855 Y131.212 E.56263
G1 X119.855 Y130.678
G1 X132.678 Y117.855 E.54017
G1 X132.145 Y117.855
G1 X119.855 Y130.145 E.5177
G1 X119.855 Y129.612
G1 X131.612 Y117.855 E.49524
G1 X131.079 Y117.855
G1 X119.855 Y129.079 E.47277
G1 X119.855 Y128.545
G1 X130.545 Y117.855 E.45031
G1 X130.012 Y117.855
G1 X119.855 Y128.012 E.42785
G1 X119.855 Y127.479
G1 X129.479 Y117.855 E.40538
G1 X128.945 Y117.855
G1 X119.855 Y126.945 E.38292
M73 P98 R0
G1 X119.855 Y126.412
G1 X128.412 Y117.855 E.36046
G1 X127.879 Y117.855
G1 X119.855 Y125.879 E.33799
G1 X119.855 Y125.346
G1 X127.346 Y117.855 E.31553
G1 X126.812 Y117.855
G1 X119.855 Y124.812 E.29306
G1 X119.855 Y124.279
G1 X126.279 Y117.855 E.2706
G1 X125.746 Y117.855
G1 X119.855 Y123.746 E.24814
G1 X119.855 Y123.213
G1 X125.213 Y117.855 E.22567
G1 X124.679 Y117.855
G1 X119.855 Y122.679 E.20321
G1 X119.855 Y122.146
G1 X124.146 Y117.855 E.18075
G1 X123.613 Y117.855
G1 X119.855 Y121.613 E.15828
G1 X119.855 Y121.08
G1 X123.08 Y117.855 E.13582
G1 X122.546 Y117.855
G1 X119.855 Y120.546 E.11335
G1 X119.855 Y120.013
G1 X122.013 Y117.855 E.09089
G1 X121.48 Y117.855
G1 X119.855 Y119.48 E.06843
G1 X119.855 Y118.946
G1 X120.946 Y117.855 E.04596
G1 X120.413 Y117.855
G1 X119.855 Y118.413 E.0235
M204 S10000
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9547.055
G1 X120.413 Y117.855 E-.29979
G1 X120.946 Y117.855 E-.20264
G1 X120.467 Y118.335 E-.25757
; WIPE_END
G1 E-.04 F1800
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; filament end gcode 
M106 P3 S0
;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z17.7 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z117.2 F600
    G1 Z115.2

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

