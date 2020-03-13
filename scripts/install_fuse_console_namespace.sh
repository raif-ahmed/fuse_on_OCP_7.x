set -x
FUSE_PROJ=fuse-local-console
HOST_NAME=fuse-local-console.apps-crc.testing
# There is a bug in this version in the grantMethod, so i just clone the repo and fix this one only
# oc describe OAuthClient/fuse76-console-oauth-client
BASEURL=application-templates-2.1.fuse-750056-redhat-00006

output=$(oc get project ${FUSE_PROJ})

if [ -z "${output}" ]; then
    echo "project doesn't exists." 
    exit ;
fi

echo "Proceeding"

rm -Rf ./certs
mkdir ./certs

oc get secrets/signing-key -n openshift-service-ca -o "jsonpath={.data['tls\.crt']}" | base64 --decode > ./certs/ca.crt

oc get secrets/signing-key -n openshift-service-ca -o "jsonpath={.data['tls\.key']}" | base64 --decode > ./certs/ca.key

openssl genrsa -out ./certs/server.key 2048

#The certificate will be good for the internal service DNS name, <service.name>.<service.namespace>.svc, it assumes that namesapce is 'fuse-console'
cat <<EOT >> ./certs/csr.conf
  [ req ]
  default_bits = 2048
  prompt = no
  default_md = sha256
  distinguished_name = dn

  [ dn ]
  CN = fuse-console.${FUSE_PROJ}.svc

  [ v3_ext ]
  authorityKeyIdentifier=keyid,issuer:always
  keyUsage=keyEncipherment,dataEncipherment,digitalSignature
  extendedKeyUsage=serverAuth,clientAuth
EOT

openssl req -new -key ./certs/server.key -out ./certs/server.csr -config certs/csr.conf

openssl x509 -req -in ./certs/server.csr -CA ./certs/ca.crt -CAkey ./certs/ca.key -CAcreateserial -out ./certs/server.crt -days 10000 -extensions v3_ext -extfile ./certs/csr.conf

openssl crl2pkcs7 -nocrl -certfile certs/server.crt | openssl pkcs7 -print_certs -text -noout

oc new-project ${FUSE_PROJ}

oc new-app -n ${FUSE_PROJ} -f ${BASEURL}/fuse-console-namespace-os4.json -p ROUTE_HOSTNAME=${HOST_NAME} -p APP_NAME=${FUSE_PROJ}

oc create secret tls ${FUSE_PROJ}-tls-proxying --cert certs/server.crt --key certs/server.key

oc status

