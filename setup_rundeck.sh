#!/bin/bash

# Step 1: Pull the Rundeck Docker image
docker pull rundeck/rundeck:5.8.0

# Step 2: Run Rundeck as a Docker container
sudo docker run -d -p 4440:4440 --name rundeck rundeck/rundeck

# Step 3: Create the necessary directories and files
mkdir -p custom_configs/deploy
mkdir -p custom_configs/trigger
mkdir -p resources

# Create example deployment files with content
cat <<EOL > custom_configs/deploy/stages.example.yaml
# Example of stages list for deploy action
stages:
  - name: stage1
    tasks:
      - task1
      - task2
EOL

cat <<EOL > custom_configs/deploy/install.example.config
# Example install config
install:
  steps:
    - step1
    - step2
EOL

cat <<EOL > custom_configs/deploy/rollback.example.config
# Example rollback config
rollback:
  steps:
    - step1
    - step2
EOL

# Create example trigger files with content
cat <<EOL > custom_configs/trigger/stages.example.yaml
# Example of stages list for trigger action
stages:
  - name: stage1
    tasks:
      - task1
      - task2
EOL

cat <<EOL > custom_configs/trigger/news-mlt-dbconn.example.config
# Example trigger config
trigger:
  steps:
    - step1
    - step2
EOL

# Create resource files with content
cat <<EOL > resources/region_abbreviations.yaml
# Resources, taken from scs-jenkins-library repo and used for input validations
us-east-1: "use1"
eu-west-1: "euw1"
ap-southeast-1: "apse1"
common: "usw2"
EOL

cat <<EOL > resources/srv_region.yaml
# Additional resource file used for input validations
regions:
  - region1
  - region2
EOL

# Create .gitignore file
cat <<EOL > .gitignore
# Files to ignore
*.pyc
__pycache__/
EOL

# Create assetinfo.json
cat <<EOL > assetinfo.json
{
  "name": "MyApp",
  "version": "1.0.0"
}
EOL

# Create README.md
cat <<EOL > README.md
# Project README
This is a project to manage multipipeline deployments using Rundeck.
EOL

# Create auth.yaml
cat <<EOL > auth.yaml
# Jenkins connection configuration
jenkins:
  url: "http://jenkins.example.com"
  username: "admin"
  password: "admin"
EOL

# Create requirements.txt
cat <<EOL > requirements.txt
# Requirements to install
python-jenkins==1.7.0
pyyaml==5.4.1
EOL

# Create devops_jenkins.py with example content
cat <<EOL > devops_jenkins.py
import utils

class DevOpsJenkins:
    def __init__(self, action, env, reg, stages, override, token, resume, git):
        self.action = action
        self.env = env
        self.reg = reg
        self.stages = stages
        self.override = override
        self.token = token
        self.resume = resume
        self.git = git
    
    def validate_inputs(self):
        print("Validating inputs...")
    
    def prepare_queue(self):
        print("Preparing job queue...")
    
    def execute_queue(self):
        print("Executing job queue...")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("action", help="Action to perform")
    parser.add_argument("env", help="Environment")
    parser.add_argument("reg", help="Region")
    parser.add_argument("stages", help="Stages")
    parser.add_argument("override", help="Override parameters")
    parser.add_argument("token", help="Token")
    parser.add_argument("resume", help="Resume deployment")
    parser.add_argument("git", help="Git parameters")
    args = parser.parse_args()

    jenkins = DevOpsJenkins(args.action, args.env, args.reg, args.stages, args.override, args.token, args.resume, args.git)
    jenkins.validate_inputs()
    jenkins.prepare_queue()
    jenkins.execute_queue()
EOL

# Create start.py with example content
cat <<EOL > start.py
import argparse
import devops_jenkins

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    validate_parser = subparsers.add_parser("validate")
    prepare_parser = subparsers.add_parser("prepare")
    execute_parser = subparsers.add_parser("execute")

    for subparser in (validate_parser, prepare_parser, execute_parser):
        subparser.add_argument("--action", required=True)
        subparser.add_argument("--env", required=True)
        subparser.add_argument("--reg", required=True)
        subparser.add_argument("--stages", required=True)
        subparser.add_argument("--override", required=True)
        subparser.add_argument("--token", required=True)
        subparser.add_argument("--resume", required=True)
        subparser.add_argument("--git", required=True)

    args = parser.parse_args()
    jenkins = devops_jenkins.DevOpsJenkins(args.action, args.env, args.reg, args.stages, args.override, args.token, args.resume, args.git)

    if args.command == "validate":
        jenkins.validate_inputs()
    elif args.command == "prepare":
        jenkins.prepare_queue()
    elif args.command == "execute":
        jenkins.execute_queue()

if __name__ == "__main__":
    main()
EOL

# Create utils.py with example content
cat <<EOL > utils.py
def beautify_terminal_output(header="", body="", border_style="="):
    print(f"{header}\n{border_style * len(header)}\n{body}")

def get_jenkins_job_name(stage_type, service_name, environment_name, action, application_name):
    return f"{stage_type}-{service_name}-{environment_name}-{action}-{application_name}"

def logging_info(message):
    print(f"INFO: {message}")

def logging_warning(message):
    print(f"WARNING: {message}")

def logging_error(message):
    print(f"ERROR: {message}")
EOL

echo "Setup complete. Rundeck is running as a Docker container."
