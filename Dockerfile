# docker build -t faiss:latest -no-cache .
# docker_id=$(docker create faiss:latest) && docker cp $docker_id:/usr/local/lib xxxx

FROM alpine:3 as base

LABEL FAISS_VERSION="1.7.4"

WORKDIR /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
  && apk update && apk --no-cache add git build-base cmake gfortran lapack-dev blas-dev \
  && wget -c 'https://github.com/facebookresearch/faiss/archive/refs/tags/v1.7.4.tar.gz' \
  && tar -zxf v1.7.4.tar.gz \
  && cd faiss-1.7.4/ \
  && sed -i '/#include <stdlib.h>/a\#include <stdint.h>' c_api/utils/distances_c.h \
  && cmake -B build -DFAISS_ENABLE_GPU=OFF -DFAISS_ENABLE_C_API=ON -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTING=OFF -DFAISS_ENABLE_PYTHON=OFF -DCMAKE_BUILD_TYPE=Release -DFAISS_OPT_LEVEL=avx2 . \
  && cmake --build build -j --target install \
  && cp build/c_api/libfaiss_c.a /usr/local/lib/ \
  && cd .. \
  && wget -c 'https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.12.0.tar.gz' \
  && tar -zxf v3.12.0.tar.gz \
  && cd lapack-3.12.0/ \
  && cmake -B build . \
  && cmake --build build -j --target install

