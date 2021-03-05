# PerlTest

Experiments to copy some of the capabilities of [Pytest](https://docs.pytest.org/).

Make this compatible with prove and `make test` by allowing a single (or multiple?) .t  files
that only runs this code.


## TODO

Add

* setup_module
* teardown_module
* setup_function
* teardown_function

* dependency injection?

* allow for "inline tests" that we write directly in the .t file and in calls `self_run`  or `run_this`

* Maybe eliminate the need to load `use PerlTest;` in every test module?

* Maybe we can simplify the writing of test so we won't need to write packages?

