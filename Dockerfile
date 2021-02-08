# Tagged build phase - doesn't work with AWS
# FROM node:alpine as builder
FROM node:alpine

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# all files will be build into /app/build

# Start run phase
FROM nginx 

# Copy from tagged builder phase intp nginx html folder 
# COPY --from=builder /app/build /usr/share/nginx/html

# Tagged builds (builder) do not work with AWS (security permissions) - so use from 0.
COPY --from=0 /app/build /usr/share/nginx/html

# No need to start up nginx.
