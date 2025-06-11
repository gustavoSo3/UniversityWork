# Start with the official Node.js image
FROM node:20

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy local files to the container
COPY . .

# Build the Next.js app
RUN npm run build

# Set the port the app listens on
EXPOSE 3000

# Command to run the app using npm
CMD [ "npm", "start" ]
