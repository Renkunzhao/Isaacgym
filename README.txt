Please refer to docs/index.html to get started.

# Installation
# Build contrainer (Optional)
```bash
cd docker
docker compose up -d --build
```

```bash
./scripts/config-uv.sh
source .venv/bin/activate

cd python/examples
python joint_monkey.py

cd lib/IsaacGymEnvs/isaacgymenvs
python train.py task=Cartpole
```