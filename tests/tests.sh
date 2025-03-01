#!/bin/bash

cookbooks=("database" "wordpress" "proxy")
base_dir="$(pwd)/cookbooks"

run_unit_tests() {
  echo "Running unit tests for all cookbooks..."
  
  for cookbook in "${cookbooks[@]}"; do
    echo "Running unit tests for cookbook: $cookbook"

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
  echo "Running integration tests for all cookbooks..."
  
  for cookbook in "${cookbooks[@]}"; do
    echo "Running integration tests for cookbook: $cookbook"
    test_dir="$base_dir/$cookbook"

    if [ -d "$test_dir" ]; then
      cd $test_dir
      kitchen test
      if [ $? -eq 0 ]; then
        echo "Integration tests for $cookbook passed.\n"
      else
        echo "Integration tests for $cookbook failed."
      fi
    else
      echo "No integration tests found for $cookbook in $test_dir."
    fi
  done

}

# Function to run both unit tests and integration tests for all cookbooks
run_entire_project() {
  echo "Running both unit and integration tests for all cookbooks..."

  run_unit_tests

  run_integration_tests
}

# Interactive selection menu
echo "Select an option to run tests:"
echo "1. Execute Unit Tests"
echo "2. Execute Integration Tests"
echo "3. Execute Entire Project (Unit + Integration)"
echo "4. Exit"

# Read user input for selection
read -p "Enter your choice (1-4): " choice

case $choice in
  1)
    run_unit_tests
    ;;
  2)
    run_integration_tests
    ;;
  3)
    run_entire_project
    ;;
  4)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option. Please choose 1-4."
    ;;
esac
