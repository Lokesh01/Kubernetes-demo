# Use a small base image
FROM node:20-alpine AS base
WORKDIR /app

# Install deps separately for caching
COPY package.json package-lock.json* ./
# skips dev dependencies (ci=clean install)
RUN npm ci --omit=dev

# Copy app source
COPY . .

# Run as non-root (alpine node image includes user 'node')
USER node
EXPOSE 3000
ENV NODE_ENV=production
CMD ["npm", "start"]


## npm ci vs npm install

### __`npm ci` (Clean Install)__ - Better for Docker/Production

# - ✅ Installs exact versions from `package-lock.json`
# - ✅ Faster installation
# - ✅ Deletes `node_modules` first (fresh install)
# - ✅ Fails if package.json and package-lock.json don't match
# - ✅ More reliable and reproducible builds
# - ⚠️ Requires `package-lock.json` to exist
