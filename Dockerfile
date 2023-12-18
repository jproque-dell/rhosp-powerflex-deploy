# Cinder driver container for Dell PowerFlex v4.x
# Using openstack-cinder-volume base image
# Version 1.29.0

FROM registry.redhat.io/rhosp-rhel9/openstack-cinder-volume:17.1

MAINTAINER Dell
LABEL description="Red Hat OpenStack Platform 17.1 cinder-volume Dell PowerFlex" \
      summary="Red Hat OpenStack Platform 17.1 cinder-volume Dell PowerFlex" \
      name="dellemc/openstack-cinder-volume-powerflex-rhosp17" \
      vendor="Dell" \
      version="1.29.1"

USER root
COPY LICENSE /licenses/licensing.txt
COPY cinder/volume/drivers/dell_emc/powerflex /usr/lib/python3.9/site-packages/cinder/volume/drivers/dell_emc/powerflex
COPY cinder/tests/unit/volume/drivers/dell_emc/powerflex/ /usr/lib/python3.9/site-packages/cinder/tests/unit/volume/drivers/dell_emc/powerflex/
COPY os_brick/initiator/connectors/scaleio.py /usr/lib/python3.9/site-packages/os_brick/initiator/connectors/scaleio.py
COPY os_brick/tests/initiator/connectors/test_scaleio.py /usr/lib/python3.9/site-packages/os_brick/tests/initiator/connectors/test_scaleio.py
RUN python3 -mcompileall /usr/lib/python3.9/site-packages/cinder/volume/drivers/dell_emc/powerflex
RUN python3 -mcompileall /usr/lib/python3.9/site-packages/os_brick/tests/initiator/connectors/test_scaleio.py


USER cinder
