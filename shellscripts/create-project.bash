#!/usr/bin/env bash
readonly DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
cd $DIR;
set -e
set -u
set -o pipefail
standardIFS="$IFS"
IFS=$'\n\t'
echo "
===========================================
$(hostname) $0 $@
===========================================
"

usage()
{
    echo "\
Create a new Ansible Project based on the Edmonds Commerce template.

Usage: bash create-project.bash [project-path]
Project name should not contain spaces
You can also use a target directory for project name e.g: "/opt/Projects/my-project"\
"
}

projectPath="${1:-}"
if [[ -z "$projectPath" ]]
then
    usage;
    exit 0;
fi

projectName="$(basename ${projectPath})";
targetDirectory="$(dirname ${projectPath})";
echo $projectName;
echo $targetDirectory;

# Ensure the parent directory exists
if [[ ! -d "$targetDirectory" ]]
then
    echo "Target path does not exist: ${targetDirectory}";
    exit 1;
fi

# Don't clobber existing projects
if [[ -d "$projectPath" ]]
then
    echo "Project at path "${projectPath}" already exists! Aborting.";
    exit 1;
fi

echo "Checking Ansible is installed"
ansibleVersion="$(ansible --version)"
ansibleInstalled=$?;

if [[ "$ansibleInstalled" != 0 ]]
then
    echo "Ansible not installed, you need to install it."
    exit 1;
fi

pipCommand="pip --no-python-version-warning"

echo "Check that the pre-commit plugin is installed";
if [[ ! "$(${pipCommand} show pre-commit)" ]]
then
    echo "Pre-commit plugin not found, installing";
    ${pipCommand} install pre-commit;
fi

echo "Cloning Template Project"
git clone git@github.com:edmondscommerce/ansible-project-template.git "$projectPath" --depth=1

echo "Removing git folder from template"
rm -rf "${projectPath}/.git"

echo "Fixing Readme Title"
sed -i "s/PROJECT_NAME/$projectName/g" "${projectPath}/README.md"

echo "Remove example data"
rm -rf "${projectPath}/environment/prod/host_vars/remote-server"
rm -rf "${projectPath}/environment/vagrant/host_vars/vagrant-machine"

echo "Re-initialising git"
(cd ${projectPath}; git init);

echo "Installing hooks";
(cd ${projectPath}; pre-commit install);

echo "Done! New project is available here: ${projectPath}";

echo "
----------------
$(hostname) $0 completed
----------------
"
