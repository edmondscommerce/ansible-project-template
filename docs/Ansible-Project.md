```bash
echo "Setting project name" 
projectName="my-infrastructure-project"

echo "Cloning Template Project" 
git clone git@github.com:edmondscommerce/ansible-project-template.git --depth=1

echo "Renaming Cloned Folder"  
mv ansible-project-template "$projectName"

echo "Entering The Project" 
cd "$projectName"

echo"Removing .git Folder"
rm -rf .git

echo "Creating Vault Secret"
echo "vault-secret-$(openssl rand -base64 32)">./ansible-project/vault-pass.secret 

echo "Fixing Readme Title"
sed -i "s/PROJECT_NAME/$projectName/g" README.md 
``` 
