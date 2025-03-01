#!/bin/bash

source ./scripts/validate_deps.sh
source ./scripts/test.sh

run_entire_project() {
  vagrant up
}

# Interactive selection menu
echo "Select an option to run tests:"
echo "1. Execute Unit Tests"
echo "2. Execute Integration Tests"
echo "3. Execute All Project Tests (Unit + Integration)"
echo "4. Execute project"
echo "5. Validate dependencies"
echo "6. Exit"

# Read user input for selection
read -p "Enter your choice (1-6): " choice

case $choice in
  1)
    validate_unit_test_dependencies || { echo "Unit test dependencies not met. Exiting."; exit 1; }
    run_unit_tests
    ;;
  2)
    validate_integration_test_dependencies || { echo "Integration test dependencies not met. Exiting."; exit 1; }
    run_integration_tests
    ;;
  3)
    validate_integration_test_dependencies || { echo "Integration test dependencies not met. Exiting."; exit 1; }
    run_all_tests
    ;;
  4)
    validate_initial_dependencies || { echo "Initial setup dependencies not met. Exiting."; exit 1; }
    run_entire_project
    ;;
  5)
    validate_all_dependencies || { echo "Dependencies not met. Exiting."; exit 1; }
    ;;
  6)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option. Please choose 1-4."
    ;;
esac
