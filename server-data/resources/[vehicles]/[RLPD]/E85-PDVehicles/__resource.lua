resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
    'handling.meta',
    'vehicles.meta',
    'carvariations.meta',
    'gator/carcols.meta',
    'trhawk/carcols.meta',
    'leo/carcols.meta',
    'gator/carcols.meta',
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'CARCOLS_FILE' 'trhawk/carcols.meta'
data_file 'CARCOLS_FILE' 'leo/carcols.meta'
data_file 'CARCOLS_FILE' 'gator/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

client_script 'vehicle_names.lua'