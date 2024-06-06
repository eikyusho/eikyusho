sort:
	@echo "Running melos sort"
	melos sort

setup_pre_commit:
	@echo "Setting up pre-commit hook"
	@echo '#!/bin/sh' > .git/hooks/pre-commit
	@echo 'make sort' >> .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit