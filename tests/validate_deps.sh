#!/bin/bash

# Function to check if a package is installed on the system and display its version
check_dependency() {
  local package=$1
  if ! command -v "$package" &> /dev/null; then
    echo "✗ $package is not installed"
    return 1
  else
    version=$($package --version 2>/dev/null || echo "Version not available")
    echo "✓ $package is installed. Version: $version"
    return 0
  fi
}

# Function to check if a gem is installed in Chef Workstation and display its version
check_workstation_dependency() {
  local gem=$1
  if ! chef gem list | grep -q "$gem"; then
    echo "✗ $gem is not installed in Chef Workstation."
    return 1
  else
    # Extract the version of the gem from the list
    version=$(chef gem list "$gem" | grep "$gem" | awk -F'[()]' '{print $2}' | head -n 1)
    echo "✓ $gem is installed in Chef Workstation. Version: $version"
    return 0
  fi
}

# Function to validate initial setup dependencies
validate_initial_deps() {
  # echo -e "\n[ Initial Setup Dependencies ]"
  check_dependency "vagrant" || return 1
  check_dependency "vboxmanage" || return 1
  check_dependency "git" || return 1
}

# Function to validate unit test dependencies
validate_unit_test_deps() {
  # echo -e "\n[ Unit Test Dependencies ]"
  validate_initial_deps || return 1
  check_dependency "chef-client" || return 1
  check_dependency "inspec" || return 1
  check_workstation_dependency "chefspec" || return 1
  check_workstation_dependency "rspec" || return 1
}

# Function to validate integration test dependencies
validate_integration_test_deps() {
  # echo -e "\n[ Integration Test Dependencies ]"
  validate_unit_test_deps || return 1
  check_dependency "kitchen" || return 1
}

# Main script execution
echo "Starting validation...\n"

validate_integration_test_deps

# Final result
if [ $? -eq 0 ]; then
  echo -e "\nAll dependencies are correctly installed."
else
  echo -e "\nSome dependencies are missing or not correctly installed."
fi
