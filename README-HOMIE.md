```bash
cd src/OpenHomie/HomieRL
uv run python legged_gym/legged_gym/scripts/train.py \
--task g1 --num_envs 4096 --headless --rl_device cuda:0 --sim_device cuda:0
```