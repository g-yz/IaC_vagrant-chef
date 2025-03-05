#!/bin/bash

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

validate_initial_dependencies() {
  check_dependency "vagrant" || return 1
  check_dependency "vboxmanage" || return 1
  check_dependency "git" || return 1
}

validate_unit_test_dependencies() {
  validate_initial_dependencies || return 1
  check_dependency "chef-client" || return 1
  check_workstation_dependency "chefspec" || return 1
  check_workstation_dependency "rspec" || return 1
}

validate_integration_test_dependencies() {
  validate_unit_test_dependencies || return 1
  check_dependency "kitchen" || return 1
  check_dependency "inspec" || return 1
}

validate_all_dependencies()
{
  echo -e "\nStarting validation..."

  validate_integration_test_dependencies

  if [ $? -eq 0 ]; then
    echo -e "\nAll dependencies are correctly installed."
  else
    echo -e "\nSome dependencies are missing or not correctly installed."
  fi
}
