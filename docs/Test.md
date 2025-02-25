# Execute integration tests

Create the VM (if not already created):
```sh
kitchen create
```
Converge the VM to apply the Chef recipes:
```sh
kitchen converge
```
Run the tests using the following command:
```sh
kitchen verify
```
(Optional) Destroy the VM after the tests have completed:
```sh
kitchen destroy
```
