# Wasm demo using SpinFramework, Rust and Docker

## Build the app
```bash
docker buildx build \
    --platform wasi/wasm \
    --provenance=false \
    --push \
    -t alexbn14/ddd-book:wasm .
```

## Run the app container
```bash
docker run -d --name wasm-ctr \
    --runtime=io.containerd.spin.v2 \
    --platform=wasi/wasm \
    -p 5556:80 \
    alexbn14/ddd-book:wasm /
```
