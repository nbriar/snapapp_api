#! /bin/sh

pwd=$(pwd)
path=$(dirname "$0")
project=`printenv GCLOUD_PROJECT`
image=`printenv IMAGE_NAME`
sha=`printenv CIRCLE_SHA1`

replace_image="<IMAGE>"
new_image="us.gcr.io/$project/$image:$sha"

replace_db_name="<DB_INSTANCE_NAME>"
db_name=`printenv DB_INSTANCE_NAME`

replace_key_base="<SECRET_KEY_BASE>"
secret_key_base=`printenv SECRET_KEY_BASE`


sed -e "s|$replace_image|$new_image|" $pwd/$path/k8s.config.tmpl.yml | sed -e "s|$replace_db_name|$db_name|" | sed -e "s|$replace_key_base|$secret_key_base|" > $pwd/$path/k8s.config.yml
