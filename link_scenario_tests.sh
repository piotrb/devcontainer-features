features=$(find src/* -type d)

for feature in $features; do
    echo "Processing $feature ..."
    feature_name=$(basename $feature)
    feature_test_dir="test/$feature_name"
    feature_path="$feature_test_dir/scenarios.json"
    scenarios=$(cat $feature_path | jq -r '. | keys[]')
    cd $feature_test_dir
    for scenario in $scenarios; do
        echo "Linking $scenario to $feature_name"
        ln -sf test.sh ${scenario}.sh
    done
    cd ../..
done
