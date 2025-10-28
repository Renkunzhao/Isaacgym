# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# Humanoid Gym
cd $PROJECT_DIR/src
git clone https://github.com/roboterax/humanoid-gym.git
cd humanoid-gym
uv pip install -e .

cd $PROJECT_DIR/lib
uv pip install torch-1.10.0a0+3fd9dcf-cp38-cp38-linux_x86_64.whl
