# Build the production retrieval image
retrieval-image:
  docker build -t ghcr.io/classicrockfan/waittimesml/retriever:latest ./retrieval

# Build the database image
db-image:
  docker build -t ghcr.io/classicrockfan/waittimesml/db:latest ./db

# Run the production image
run: retrieval-image db-image
  docker compose up -d

# Clean up all the logs and node_modules
clean:
  -rm -r retrieval/node_modules/
  -rm *.db
  -rm *.log

# Print this help message
help:
  just --list
