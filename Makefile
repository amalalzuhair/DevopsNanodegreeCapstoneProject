setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install --no-cache-dir -r requirements.txt
	# Install hadolint
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
	chmod +x /bin/hadolint
test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 web.py

docker-build:  ## Build the docker image and list available docker images
	docker build -t amalsz/capstone-project .
	docker image ls

docker-upload: ## Upload the docker image to AWS
	$(aws ecr get-login --no-include-email --region us-east-1)
	docker tag capstone-project:latest 253490030767.dkr.ecr.us-east-1.amazonaws.com/capstone-project:latest
	docker push 253490030767.dkr.ecr.us-east-1.amazonaws.com/capstone-project

start-api:     ## Run the python application locally
	python web.py
all: install lint test