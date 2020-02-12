### Base Stage
FROM node as base
WORKDIR /usr/src/app
COPY package.json .


### Build Dependencies Stage
FROM base AS dependencies
RUN npm set progress=false && npm config set depth 0
# install production dependencies and save aside for our release stage
RUN npm install --production 
RUN cp -R node_modules prod_node_modules
# install ALL node_modules, including 'devDependencies'
RUN npm install


### Test Stage
FROM dependencies AS test
COPY . .
RUN  npm run test


### Release Stage
FROM base AS release
# copy production node_modules
COPY --from=dependencies /usr/src/app/prod_node_modules ./node_modules
# copy app sources
COPY . .

