GPU_ID=$1

solver_template_path=data/nets_config/64c5-128c5-256c5-512f/template/solver.prototxt 

old_line=$(grep "device_id: [0-9]*" $solver_template_path)
sed  -i "s/device_id: [0-9]*/device_id: $GPU_ID/" $solver_template_path
new_line=$(grep "device_id: [0-9]*" $solver_template_path)

echo "changed: '$old_line' --> '$new_line'"
