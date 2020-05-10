PIP_FOUND := $(shell command -v pip 2> /dev/null)
PYTHON_PATH := $(HOME)/Library/Python/2.7/bin
PYTHON3_PATH := $(HOME)/Library/Python/3.7/bin

.PHONY: \
	install_pip \
	install_ansible \
	install_galaxy_roles \
	install_commandlinetools \
	install_homebrew \
	install_ios \
	install_python3 \
	install_ruby \
	install_fastlane \
	install_rome \
	install_mas \
	install_xcode \
	install_swiftlint \
	clean

install: \
	install_pip \
	install_ansible \
	install_galaxy_roles \
	install_commandlinetools \
	install_homebrew \
	install_ios


install_pip:
ifndef PIP_FOUND
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py --user --force-reinstall
	rm -f get-pip.py
endif

install_ansible:
	@export PATH="$(PYTHON_PATH):$$PATH"; pip install --user --ignore-installed six ansible

install_galaxy_roles:
	@export PATH="$(PYTHON_PATH):$$PATH"; ansible-galaxy install -r requirements.yml

install_commandlinetools:
	@export PATH="$(PYTHON_PATH):$$PATH"; ansible-playbook main.yml -i inventory --tags "command-line-tools"

install_homebrew:
	@export PATH="$(PYTHON_PATH):$$PATH"; ansible-playbook main.yml -i inventory --tags "homebrew"

install_ios:
	@export PATH="$(PYTHON_PATH):$$PATH"; ansible-playbook main.yml -i inventory --tags "ios"

install_python3:
	@export PATH="$(PYTHON_PATH):$$PATH"; ansible-playbook main.yml -i inventory --tags "python3"
	@export PATH="$(PYTHON3_PATH):$$PATH"; pip3 install --user --ignore-installed six ansible

install_ruby:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "ruby" $(ARGS)

install_fastlane:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "fastlane" $(ARGS)

install_rome:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "rome" $(ARGS)

install_mas:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "mas" $(ARGS)

install_xcode:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "xcode" $(ARGS)

install_swiftlint:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-playbook playbook.yml -i inventory --tags "swiftlint" $(ARGS)

clean:
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-galaxy remove elliotweiser.osx-command-line-tools
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-galaxy remove geerlingguy.homebrew
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-galaxy remove geerlingguy.mas
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-galaxy remove martianplatypus.ruby_mac
	@export PATH="$(PYTHON3_PATH):$$PATH"; ansible-galaxy remove martianplatypus.python_mac
