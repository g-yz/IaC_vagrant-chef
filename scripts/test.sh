#!/bin/bash

cookbooks=("database" "wordpress" "proxy")
base_dir="$(pwd)/cookbooks"

run_unit_tests() {
  echo -e "\nRunning unit tests for all cookbooks..."
  
  for cookbook in "${cookbooks[@]}"; do
    echo -e "\nRunning unit tests for cookbook: $cookbook"

    test_dir="/$base_dir/$cookbook"

    if [ -d "$test_dir" ]; then
      cd "$test_dir" && chef exec rspec --format=documentation
      if [ $? -eq 0 ]; then
        echo "Unit tests for $cookbook passed."
      else
        echo "Unit tests for $cookbook failed."
      fi
    else
      echo "No unit tests found for $cookbook in $test_dir."
    fi
  done
}

run_integration_tests() {
  echo -e "\nRunning integration tests for all cookbooks..."
  
  for cookbook in "${cookbooks[@]}"; do
    echo -e "\nRunning integration tests for cookbook: $cookbook"
    test_dir="$base_dir/$cookbook"

    if [ -d "$test_dir" ]; then
      cd $test_dir
      kitchen test
      if [ $? -eq 0 ]; then
        echo "Integration tests for $cookbook passed."
      else
        echo "Integration tests for $cookbook failed."
      fi
    else
      echo "No integration tests found for $cookbook in $test_dir."
    fi
  done

}

run_all_tests() {
  echo -e "\nRunning both unit and integration tests for all cookbooks..."

  run_unit_tests
  run_integration_tests
}
