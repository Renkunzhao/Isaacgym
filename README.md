## Getting Started

Please refer to **`docs/index.html`** for detailed usage instructions.  
This repository provides the necessary **Dockerfiles** and scripts to run **IsaacGym on RTX 50-series GPUs**.

---

## Background

The version of **PyTorch** that supports **NVIDIA RTX 50-series GPUs** requires **Python 3.10 or newer**,  
while **IsaacGym** officially supports only **Python 3.8**.

To resolve this incompatibility, [this article](https://blog.csdn.net/m0_56706433/article/details/148902144)  
demonstrates how to build **PyTorch 2.3.1** from source with Python 3.8 and CUDA 12.8.

---

## Release Builds

Two pre-built wheels are available in the **Releases** section:

| File | Python | CUDA | glibc |
|------|---------|------|-------|
| `torch-1.10.0a0+3fd9dcf-cp38-cp38-linux_x86_64.whl` | 3.8 | 12.8 | 2.31 |
| `torch-2.3.0a0+gitd72f1d2-cp38-cp38-linux_x86_64.whl` | 3.8 | 12.8 | 2.39 |

Since **glibc** is backward-compatible, it is recommended to **try the 1.10.0a0 build first**.

---

## Usage Notes

- A **Dockerfile** is provided to ensure that the pre-built PyTorch wheel runs correctly.  
- If you choose not to use Docker, you can still follow the Dockerfile to install the required libraries manually.  
  However, **using Docker is strongly recommended** for stability and reproducibility.

---

## Requirements

- **CUDA ≥ 12.8**
- **pip** or **wget** (required only if installing `uv` manually on the host)

> ⚠️ If you are running inside the provided Docker container, `uv` is already pre-installed.  
> If you are running on the host machine, you need to install it manually using either `pip` or `wget`.

```bash
# Option 1: Install via pip
pip install uv

# Option 2: Install via wget
wget -qO- https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
```

## Installation
### Build contrainer (Optional)
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

cd src/MimicKit
python mimickit/run.py --arg_file args/deepmimic_humanoid_ppo_args.txt --visualize true

cd src/humanoid-gym/humanoid
python scripts/train.py --task=humanoid_ppo --run_name v1 --headless --num_envs 4096
```