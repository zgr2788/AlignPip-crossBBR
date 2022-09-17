prep : bin/dag.sh bin/setup.sh bin/pip.sh
	@cp bin/dag.sh bin/setup.sh bin/pip.sh bin/config.yaml bin/Snakefile .
	@bash setup.sh
	@rm setup.sh

clean : 
	@rm -rf pip.sh dag.sh runFiles

softclean: 
	@rm -rf runFiles
