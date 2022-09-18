prep : bin/dag.sh bin/setup.sh bin/pip.sh
	@cp bin/dag.sh bin/setup.sh bin/pip.sh bin/config.yaml bin/Snakefile bin/extractTables.sh .
	@bash setup.sh
	@rm setup.sh
	@bash extractTables.sh
	@rm extractTables.sh

clean : 
	@rm -rf pip.sh dag.sh runFiles config.yaml Paired Single Benchmarks

softclean: 
	@rm -rf runFiles Paired Single Benchmarks

updatetable:
	@clear
	@cp bin/extractTables.sh .
	@bash extractTables.sh
	@rm extractTables.sh
