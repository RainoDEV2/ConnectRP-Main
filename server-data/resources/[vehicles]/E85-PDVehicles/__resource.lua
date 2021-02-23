resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
    'data/**/handling.meta',
    'data/**/vehicles.meta',
    'data/**/carcols.meta',
    'data/**/carvariations.meta',
    'data/**/vehiclelayouts.meta',

    --Swat Insurgent--
    'swat/vehicles.meta',
    'swat/carvariations.meta',
    'swat/handling.meta',
    'swat/carcols.meta',
    'swat/vehiclelayouts.meta',
}


data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.META'

--Swat Insurgent--
data_file 'VEHICLE_METADATA_FILE' 'swat/vehicles.meta'
data_file 'HANDLING_FILE' 'swat/handling.meta'
data_file 'CARCOLS_FILE' 'swat/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'swat/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'swat/vehiclelayouts.META'

client_script 'vehicle_names.lua'