FROM lambci/lambda:build-python3.7

RUN pip3 install sagemaker -t /tmp/vendored 
RUN rm -rdf /tmp/vendored/boto3/
RUN rm -rdf /tmp/vendored/botocore/
RUN rm -rdf /tmp/vendored/numpy/
RUN rm -rdf /tmp/vendored/scipy/
RUN rm -rdf /tmp/vendored/s3transfer/
RUN find /tmp/vendored -type f -name '*.pyc' | while read f; do n=$(echo $f | sed 's/__pycache__\///' | sed 's/.cpython-37//'); cp $f $n; done;
RUN find /tmp/vendored -type d -a -name '__pycache__' -print0 | xargs -0 rm -rf
RUN find /tmp/vendored -type f -a -name '*.py' -print0 | xargs -0 rm -f
RUN du -sh /tmp/vendored
RUN cd /tmp/vendored && zip -r9q /tmp/package.zip *
RUN du -sh /tmp/package.zip
ENTRYPOINT bash
