# NOTE
This project is about a simple website with a pic of a valley and a button to play the sound of it
I hope you will enjoy as much as I did seeing the valley and earing the sound of it ^_^ !

Before running terraform init:
export TF_VAR_appstackcode="xxx"
export TF_VAR_aws_env="xxx" 
export TF_VAR_shortEnv="xxx" 
export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="xxx"
In GitHub be sure that you added under variable appstackode under variables (settings/security/secrets&variables/actions/variables)
In GitHub be sure that you added under secrets (settings/security/secrets&variables/actions/secret) 
.. in GitHub AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY !!!

# Upload Website Content
After the S3 bucket is created, you need to upload your website content in the S3 bucket 
(e.g., index.html, error.html, the pic and the mp3 file) 
After uploaded the stuff, run the website by doing:
http://s3-us-east-1-tizi-p-website.s3-website-us-east-1.amazonaws.com/

# NOTE General
In this project I used GitHub to store variables and secrets and Terraform 
Is assumed as well that you have installed Git, Terraform and AWS CLI
To use Terraform do the below in order:
terraform init
terraform plan
terraform apply
To destroy all do-> terraform destroy

