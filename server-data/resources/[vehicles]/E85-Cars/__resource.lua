resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
    'data/**/handling.meta',
    'data/**/vehicles.meta',
    'data/**/carcols.meta',
    'data/**/carvariations.meta',
    'data/**/vehiclelayouts.meta',
    'data/**/dlctext.meta',
    'data/**/caraddoncontentunlocks.meta',
}


data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.META'
data_file 'DLC_TEXT' 'data/**/dlctext.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/**/contentunlocks.meta'

client_script 'vehicle_names.lua'