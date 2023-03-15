DIR=build && \
rm -rf ${DIR}; \
mkdir -p ${DIR}; \
cd ${DIR} && cmake .. && cmake --build . && bin/player ../sample_960x400_ocean_with_audio.ts