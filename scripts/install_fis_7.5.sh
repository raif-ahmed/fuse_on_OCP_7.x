oc patch configs.samples.operator.openshift.io cluster --type=merge -p '{"spec":{"skippedImagestreams":["fis-java-openshift","fis-karaf-openshift","fuse7-console","fuse7-eap-openshift","fuse7-java-openshift","fuse7-karaf-openshift","jboss-fuse70-console","jboss-fuse70-eap-openshift","jboss-fuse70-java-openshift","jboss-fuse70-karaf-openshift","fuse-apicurito-generator","apicurito-ui"]}}'

oc patch configs.samples.operator.openshift.io cluster --type=merge -p '{"spec":{"skippedTemplates":["s2i-fuse75-eap-camel-amq","s2i-fuse75-eap-camel-cdi","s2i-fuse75-eap-camel-cxf-jaxrs","s2i-fuse75-eap-camel-cxf-jaxws","s2i-fuse75-eap-camel-jpa","s2i-fuse75-karaf-camel-amq","s2i-fuse75-karaf-camel-log","s2i-fuse75-karaf-camel-rest-sql","s2i-fuse75-karaf-cxf-rest","s2i-fuse75-spring-boot-camel","s2i-fuse75-spring-boot-camel-amq","s2i-fuse75-spring-boot-camel-config","s2i-fuse75-spring-boot-camel-drools","s2i-fuse75-spring-boot-camel-infinispan","s2i-fuse75-spring-boot-camel-rest-sql","s2i-fuse75-spring-boot-camel-rest-3scale","s2i-fuse75-spring-boot-camel-xa","s2i-fuse75-spring-boot-camel-xml","s2i-fuse75-spring-boot-cxf-jaxrs","s2i-fuse75-spring-boot-2-camel-amq","s2i-fuse75-spring-boot-2-camel-drools","s2i-fuse75-spring-boot-2-camel-infinispan","s2i-fuse75-spring-boot-2-camel-rest-3scale","s2i-fuse75-spring-boot-2-camel-rest-sql","s2i-fuse75-spring-boot-2-camel-teiid","s2i-fuse75-spring-boot-2-camel","s2i-fuse75-spring-boot-2-camel-xa","s2i-fuse75-spring-boot-2-camel-xml","s2i-fuse75-spring-boot-2-cxf-jaxrs","s2i-fuse75-spring-boot-2-cxf-jaxws"]}}'


BASEURL=https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.fuse-750056-redhat-00006
BASEURL_SB=https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.fuse-sb2-750016-redhat-00005
#BASEURL=https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.0.fuse-760040-redhat-00001
#BASEURL_SB=https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.0.fuse-sb2-760037-redhat-00001

oc replace --force -n openshift -f ${BASEURL}/fis-image-streams.json

for template in eap-camel-amq-template.json \
 eap-camel-cdi-template.json \
 eap-camel-cxf-jaxrs-template.json \
 eap-camel-cxf-jaxws-template.json \
 eap-camel-jpa-template.json \
 karaf-camel-amq-template.json \
 karaf-camel-log-template.json \
 karaf-camel-rest-sql-template.json \
 karaf-cxf-rest-template.json \
 spring-boot-camel-amq-template.json \
 spring-boot-camel-config-template.json \
 spring-boot-camel-drools-template.json \
 spring-boot-camel-infinispan-template.json \
 spring-boot-camel-rest-sql-template.json \
 spring-boot-camel-rest-3scale-template.json \
 spring-boot-camel-template.json \
 spring-boot-camel-xa-template.json \
 spring-boot-camel-xml-template.json \
 spring-boot-cxf-jaxrs-template.json \
 spring-boot-cxf-jaxws-template.json ;
 do
 oc replace --force -n openshift -f ${BASEURL}/quickstarts/${template}
 done

for template in spring-boot-2-camel-amq-template.json \
 spring-boot-2-camel-drools-template.json \
 spring-boot-2-camel-infinispan-template.json \
 spring-boot-2-camel-rest-3scale-template.json \
 spring-boot-2-camel-rest-sql-template.json \
 spring-boot-2-camel-teiid-template.json \
 spring-boot-2-camel-template.json \
 spring-boot-2-camel-xa-template.json \
 spring-boot-2-camel-xml-template.json \
 spring-boot-2-cxf-jaxrs-template.json \
 spring-boot-2-cxf-jaxws-template.json ;
 do
 oc replace --force -n openshift -f ${BASEURL_SB}/quickstarts/${template}
 done
