#!/usr/bin/env bash

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

if [[ -d "$projectPath" ]]
then
    echo "Project at path "${projectPath}" already exists! Aborting.";
    exit 1;
fi

echo "Cloning Template Project"
git clone git@github.com:edmondscommerce/ansible-project-template.git "$projectPath" --depth=1

echo "Removing git folder from template"
rm -rf "${projectPath}/.git"

echo "Fixing Readme Title"
sed -i "s/PROJECT_NAME/$projectName/g" "${projectPath}/README.md"

echo "Done! New project is available here: ${projectPath}";