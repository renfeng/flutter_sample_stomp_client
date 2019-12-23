# flutter sample stomp client

Experiment with stream builder and inherited widget

## Getting Started

Build (optional - only required for testing local changes)
```
docker build -t renfeng/rabbitmq_web_stomp docker
```

Run
```
docker run -it --rm --name rabbit -p 15672:15672 -p 15674:15674 renfeng/rabbitmq_web_stomp
docker exec -it rabbit bash -c "$(cat init.sh)"
```
