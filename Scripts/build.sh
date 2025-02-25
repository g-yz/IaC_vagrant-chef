
# 1. Install Chef Workstation (skip if already installed)
# Follow installation instructions from https://www.chef.io/products/chef-workstation

# 2. Generate the Chef repository
chef generate repo IaC_vagrant-chef
cd IaC_vagrant-chef

# 3. Generate cookbooks
chef generate cookbook cookbooks/database
chef generate cookbook cookbooks/wordpress
chef generate cookbook cookbooks/proxy

# 4. Create .kitchen.yml manually (use the structure from the previous response)
touch .kitchen.yml
# Edit the file to match your requirements

# 5. Generate InSpec tests (optional)
chef generate inspec IaC_vagrant-chef/test/integration/default
