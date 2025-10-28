# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# rsl rl
cd $PROJECT_DIR/src
git clone https://github.com/leggedrobotics/rsl_rl.git
cd rsl_rl
git checkout v1.0.2
uv pip install -e .

# unitree_rl_gym
cd $PROJECT_DIR/src
git clone https://github.com/unitreerobotics/unitree_rl_gym.git
cd unitree_rl_gym
uv pip install -e .

cd $PROJECT_DIR/lib
uv pip install torch-1.10.0a0+3fd9dcf-cp38-cp38-linux_x86_64.whl
