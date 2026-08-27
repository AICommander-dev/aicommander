# Glama (and similar registries) evaluate the stdio MCP by starting this
# image and sending initialize + tools/list. The published package
# @aicommander/mcp registers tools locally; AICOMMANDER_TOKEN is optional
# and only needed for account/alias features, not for introspection.
FROM node:22-alpine
WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev
ENV AICOMMANDER_SERVER=https://aicommander.dev
ENTRYPOINT ["node", "node_modules/@aicommander/mcp/dist/bin/mcp.js"]
