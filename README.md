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
uv run python joint_monkey.py

cd lib/IsaacGymEnvs/isaacgymenvs
uv run python train.py task=Cartpole

cd src/MimicKit
uv run python mimickit/run.py --arg_file args/deepmimic_humanoid_ppo_args.txt --visualize true

cd src/humanoid-gym/humanoid
uv run python scripts/train.py --task=humanoid_ppo --run_name v1 --headless --num_envs 4096
uv run python scripts/play.py --task=humanoid_ppo --run_name v1

cd src/unitree_rl_gym
uv run python legged_gym/scripts/train.py --task=g1

# HumanoidVerse
cd src/HumanoidVerse
uv run python humanoidverse/train_agent.py \
+simulator=isaacgym \
+exp=locomotion \
+domain_rand=NO_domain_rand \
+rewards=loco/reward_h1_locomotion \
+robot=h1/h1_10dof \
+terrain=terrain_locomotion_plane \
+obs=loco/leggedloco_obs_singlestep_withlinvel \
num_envs=1 \
project_name=TESTInstallation \
experiment_name=H110dof_loco_IsaacGym \
headless=False

# ASAP
cd src/ASAP

# test
HYDRA_FULL_ERROR=1 \
uv run python humanoidverse/train_agent.py \
+simulator=isaacgym \
+exp=locomotion \
+domain_rand=NO_domain_rand \
+rewards=loco/reward_g1_locomotion \
+robot=g1/g1_29dof_anneal_23dof \
+terrain=terrain_locomotion_plane \
+obs=loco/leggedloco_obs_singlestep_withlinvel \
num_envs=1 \
project_name=TestIsaacGymInstallation \
experiment_name=G123dof_loco \
headless=False

# Train a phase-based motion tracking policy to imitate Cristiano Ronaldo's signature Siuuu move
uv run python humanoidverse/train_agent.py \
+simulator=isaacgym \
+exp=motion_tracking \
+domain_rand=NO_domain_rand \
+rewards=motion_tracking/reward_motion_tracking_dm_2real \
+robot=g1/g1_29dof_anneal_23dof \
+terrain=terrain_locomotion_plane \
+obs=motion_tracking/deepmimic_a2c_nolinvel_LARGEnoise_history \
num_envs=4096 \
project_name=MotionTracking \
experiment_name=MotionTracking_CR7 \
robot.motion.motion_file="humanoidverse/data/motions/g1_29dof_anneal_23dof/TairanTestbed/singles/0-TairanTestbed_TairanTestbed_CR7_video_CR7_level1_filter_amass.pkl" \
rewards.reward_penalty_curriculum=True \
rewards.reward_penalty_degree=0.00001 \
env.config.resample_motion_when_training=False \
env.config.termination.terminate_when_motion_far=True \
env.config.termination_curriculum.terminate_when_motion_far_curriculum=True \
env.config.termination_curriculum.terminate_when_motion_far_threshold_min=0.3 \
env.config.termination_curriculum.terminate_when_motion_far_curriculum_degree=0.000025 \
robot.asset.self_collisions=0
```