include .env
export

M ?= gnuhealth

.PHONY: run

run:
	trytond -c trytond.conf -d $(TRYTON_DB) --dev -vv

update:
	trytond-admin -c trytond.conf -d $(TRYTON_DB) --all -vvv

# Update/Install module
# args: module_name
# example: $ make u_m M=gnuhealth
u_m:
	trytond-admin -c trytond.conf -d $(TRYTON_DB) -u $(M) -vvv
# db-create:
# 	createdb $(TRYTON_DB) || true
# 	$(TRYTOND_ADMIN) -c trytond.conf -d $(TRYTON_DB) --all
#
# db-drop:
# 	dropdb --if-exists $(TRYTON_DB)
#
# db-reset: db-drop db-create
#
# test:
# 	$(PYTEST) -q --maxfail=1 --disable-warnings
#
# lint:
# 	$(RUFF) check src
# 	$(MYPY) src || true
#
# fmt:
# 	$(BLACK) src
# 	$(RUFF) check --fix src
