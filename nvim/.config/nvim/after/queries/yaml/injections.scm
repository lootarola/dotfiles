; extends

((block_mapping_pair
  key: (flow_node) @_key
  value: (block_node (block_scalar) @injection.content))
 (#match? @_key "^runs$")
 (#set! injection.language "bash"))
