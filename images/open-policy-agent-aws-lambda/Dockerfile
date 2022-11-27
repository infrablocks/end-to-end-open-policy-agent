FROM docker.io/infrablocks/open-policy-agent-aws-lambda:0.1.0-rc.21

RUN mkdir -p /opt/opa/policies
COPY policies /opt/opa/policies

ADD VERSION /VERSION
ADD TAG /TAG
