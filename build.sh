#/usr/bin/env bash

docker build -t 'faiss:v1.7.4' .

docker_id=$(docker create faiss:v1.7.4)
docker cp $docker_id:/usr/local/lib/libfaiss.a lib/linux_amd64/
docker cp $docker_id:/usr/local/lib/libfaiss_avx2.a lib/linux_amd64/
docker cp $docker_id:/usr/local/lib/libfaiss_c.a lib/linux_amd64/
docker cp $docker_id:/usr/local/lib/libblas.a lib/linux_amd64/
docker cp $docker_id:/usr/local/lib/liblapack.a lib/linux_amd64/
docker cp $docker_id:/usr/lib/libgfortran.a lib/linux_amd64/
docker cp $docker_id:/usr/lib/libquadmath.a lib/linux_amd64/
docker cp $docker_id:/usr/lib/libgomp.a lib/linux_amd64/
docker cp $docker_id:/usr/lib/stdc++.a lib/linux_amd64/
