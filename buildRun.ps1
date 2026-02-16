#python setup.py install; [Environment]::SetEnvironmentVariable("FLASK_APP", "hello"); flask run

# docker
docker build --platform=linux/amd64 -t christopherjdl/containers-to-fargate:latest .
docker run -p 8080:8080 containers-to-fargate:local