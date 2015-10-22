#!/bin/sh

set -e

repos="openshift/origin openshift/nodejs-ex openshift/django-ex openshift/rails-ex openshift/dancer-ex openshift/cakephp-ex jboss-openshift/application-templates"

fetch_repo_master() {
  local org=$(echo -n "$1" | cut -d '/' -f 1)
  local repo=$(echo -n "$1" | cut -d '/' -f 2)
  curl -4 -L https://github.com/${org}/${repo}/archive/master.zip -o ${repo}-master.zip
}

tmp=$(mktemp -d)
cd ${tmp}
for name in $repos; do
  fetch_repo_master "${name}"
  local archive="$(echo -n "${name}" | cut -d '/' -f 2)-master.zip"
  (unzip -q ${archive} && rm -rf ${archive} ) &
done
for name in $repos; do wait; done

mkdir -p /templates && cd /templates
mkdir -p db-templates
mkdir -p quickstart-templates
mkdir -p image-streams
mkdir -p quickstart-templates
mkdir -p xpaas-streams
mkdir -p xpaas-templates

cp ${tmp}/origin-master/examples/db-templates/*   ./db-templates/
cp ${tmp}/origin-master/examples/image-streams/*  ./image-streams/
cp ${tmp}/django-ex-master/openshift/templates/*  ./quickstart-templates/
cp ${tmp}/rails-ex-master/openshift/templates/*   ./quickstart-templates/
cp ${tmp}/nodejs-ex-master/openshift/templates/*  ./quickstart-templates/
cp ${tmp}/dancer-ex-master/openshift/templates/*  ./quickstart-templates/
cp ${tmp}/cakephp-ex-master/openshift/templates/* ./quickstart-templates/

cp ${tmp}/origin-master/examples/jenkins/jenkins-*template.json ./quickstart-templates/
cp ${tmp}/application-templates-master/jboss-image-streams.json ./xpaas-streams/

find ${tmp}/application-templates-master/ -name '*.json' ! -wholename '*secret*' \
  -exec cp {} ./xpaas-templates/ \;
rm -rf ${tmp}
