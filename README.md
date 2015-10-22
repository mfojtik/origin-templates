#### origin-templates

This repository contains sources for the `mfojtik/origin-templates` Docker image that you can pull from the DockerHub:

```console
$ docker pull mfojtik/origin-templates
```

This image contains all OpenShift Origin v3 template and image stream files needed for bootstraping new installation
of OpenShift. To use this images, simply create the directory where do you want to install the JSON files:

```console
$ mkdir templates && cd templates
```

And then run following command to copy templates from the image to this directory:

```console
$ docker run --rm mfojtik/origin-templates | tar x
```

## Files included:

* OpenShift Origin v3 RHEL7 and CentOS7 [image streams](https://github.com/openshift/origin/tree/master/examples/image-streams)
* [xPaaS templates](https://github.com/jboss-openshift/application-templates)
* Example applications (nodejs, rails, dancer, cakephp, django ...)
* Database templates (mysql, postgresql, mongodb)
* Jenkins template
* ... and more
